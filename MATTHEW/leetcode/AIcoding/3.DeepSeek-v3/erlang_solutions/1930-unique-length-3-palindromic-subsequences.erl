-module(solution).
-export([count_palindromic_subsequence/1]).

count_palindromic_subsequence(S) ->
    First = maps:new(),
    Last = maps:new(),
    {First1, Last1} = lists:foldl(fun(Char, {F, L}) ->
        case maps:is_key(Char, F) of
            true -> {F, maps:put(Char, Char, L)};
            false -> {maps:put(Char, Char, F), L}
        end
    end, {First, Last}, S),
    Chars = lists:usort(S),
    lists:foldl(fun(Char, Acc) ->
        case {maps:is_key(Char, First1), maps:is_key(Char, Last1)} of
            {true, true} ->
                FirstPos = string:chr(S, Char),
                LastPos = string:rchr(S, Char),
                if
                    LastPos > FirstPos + 1 ->
                        Middle = string:substr(S, FirstPos + 1, LastPos - FirstPos - 1),
                        Acc + length(lists:usort(Middle));
                    true -> Acc
                end;
            _ -> Acc
        end
    end, 0, Chars).