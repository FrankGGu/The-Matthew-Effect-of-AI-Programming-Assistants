-module(ones_and_zeroes).
-export([find_max_form/3]).

find_max_form(Strs, M, N) ->
    find_max_form(Strs, M, N, []).

find_max_form(Strs, M, N, Memo) ->
    Len = length(Strs),

    find_max_form_helper(Strs, M, N, 0, Len, Memo).

find_max_form_helper(Strs, M, N, Index, Len, Memo) ->
    case Index >= Len of
        true ->
            0;
        false ->
            Key = {Index, M, N},
            case lists:keyfind(Key, 1, Memo) of
                false ->
                    {Zeros, Ones} = count_zeros_and_ones(lists:nth(Index + 1, Strs)),
                    case (M >= Zeros) and (N >= Ones) of
                        true ->
                            With = 1 + find_max_form_helper(Strs, M - Zeros, N - Ones, Index + 1, Len, Memo),
                            Without = find_max_form_helper(Strs, M, N, Index + 1, Len, Memo),
                            Max = max(With, Without),
                            NewMemo = [{Key, Max} | Memo],
                            Max;
                        false ->
                            Without = find_max_form_helper(Strs, M, N, Index + 1, Len, Memo),
                            NewMemo = [{Key, Without} | Memo],
                            Without
                    end;
                {Key, Value} ->
                    Value
            end
    end.

count_zeros_and_ones(Str) ->
    count_zeros_and_ones(Str, 0, 0, 1).

count_zeros_and_ones([], Zeros, Ones, _) ->
    {Zeros, Ones};
count_zeros_and_ones([H|T], Zeros, Ones, Pos) ->
    case H of
        $0 ->
            count_zeros_and_ones(T, Zeros + 1, Ones, Pos + 1);
        $1 ->
            count_zeros_and_ones(T, Zeros, Ones + 1, Pos + 1);
        _ ->
            count_zeros_and_ones(T, Zeros, Ones, Pos + 1)
    end.