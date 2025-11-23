-module(solution).
-export([common_chars/1]).

common_chars(Words) ->
    FoldFun = fun(W, Acc) ->
        lists:foldl(fun(C, Acc2) ->
            case lists:keymember(C, 1, Acc2) of
                true -> lists:keyreplace(C, 1, Acc2, {C, lists:min([lists:keyfind(C, 1, Acc2, 0), count_char(W, C)])});
                false -> Acc2 ++ [{C, count_char(W, C)}]
            end
        end, Acc, lists:usort(W))
    end,
    Initial = [],
    Result = lists:foldl(FoldFun, Initial, Words),
    lists:flatmap(fun({C, N}) -> lists:duplicate(N, C) end, Result).

count_char(Str, Char) ->
    count_char(Str, Char, 0).

count_char([], _, Count) ->
    Count;
count_char([H | T], Char, Count) ->
    if
        H == Char -> count_char(T, Char, Count + 1);
        true -> count_char(T, Char, Count)
    end.