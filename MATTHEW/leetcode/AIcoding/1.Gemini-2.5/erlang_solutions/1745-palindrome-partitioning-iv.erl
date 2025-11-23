-module(solution).
-export([palindrome_partitioning_iv/1]).

palindrome_partitioning_iv(S) ->
    Bin = list_to_binary(S),
    N = byte_size(Bin),

    if
        N < 3 -> false;
        true ->
            IsPalindromeTable = build_palindrome_dp_table(Bin, N),
            check_partitions(N, IsPalindromeTable)
    end.

build_palindrome_dp_table(Bin, N) ->
    InitialRow = array:new(N, false),
    IsPalindromeTable = array:from_list(lists:duplicate(N, InitialRow)),

    IsPalindromeTable1 =
        lists:foldl(fun(I, CurrentTable) ->
            Row = array:get(I, CurrentTable),
            UpdatedRow = array:set(I, true, Row),
            array:set(I, UpdatedRow, CurrentTable)
        end, IsPalindromeTable, lists:seq(0, N-1)),

    IsPalindromeTable2 =
        lists:foldl(fun(I, CurrentTable) ->
            if
                I + 1 < N andalso binary:at(Bin, I) == binary:at(Bin, I+1) ->
                    Row = array:get(I, CurrentTable),
                    UpdatedRow = array:set(I+1, true, Row),
                    array:set(I, UpdatedRow, CurrentTable);
                true ->
                    CurrentTable
            end
        end, IsPalindromeTable1, lists:seq(0, N-2)),

    lists:foldl(fun(Len, CurrentTable) ->
        lists:foldl(fun(I, InnerTable) ->
            J = I + Len - 1,
            if
                J < N ->
                    CharI = binary:at(Bin, I),
                    CharJ = binary:at(Bin, J),
                    PrevRow = array:get(I+1, InnerTable),
                    PrevIsPalindrome = array:get(J-1, PrevRow),
                    if
                        CharI == CharJ andalso PrevIsPalindrome ->
                            Row = array:get(I, InnerTable),
                            UpdatedRow = array:set(J, true, Row),
                            array:set(I, UpdatedRow, InnerTable);
                        true ->
                            InnerTable
                    end;
                true ->
                    InnerTable
            end
        end, CurrentTable, lists:seq(0, N - Len))
    end, IsPalindromeTable2, lists:seq(3, N)).

is_palindrome_check(I, J, Table) ->
    if
        I > J -> false;
        true ->
            Row = array:get(I, Table),
            array:get(J, Row)
    end.

check_partitions(N, IsPalindromeTable) ->
    lists:any(fun(I) ->
        lists:any(fun(J) ->
            Part1 = is_palindrome_check(0, I-1, IsPalindromeTable),
            Part2 = is_palindrome_check(I, J-1, IsPalindromeTable),
            Part3 = is_palindrome_check(J, N-1, IsPalindromeTable),
            Part1 andalso Part2 andalso Part3
        end, lists:seq(I+1, N-1))
    end, lists:seq(1, N-2)).