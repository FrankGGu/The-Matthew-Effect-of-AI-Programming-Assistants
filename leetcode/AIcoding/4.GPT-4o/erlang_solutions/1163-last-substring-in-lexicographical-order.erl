-module(solution).
-export([last_substring/1]).

last_substring(S) ->
    Max = lists:max(string:to_list(S)),
    MaxIndex = lists:foldl(fun(X, {Index, MaxIndex}) ->
        case X of
            _ when X > MaxIndex -> {Index + 1, X};
            _ -> {Index + 1, MaxIndex}
        end
    end, {0, $\0}, string:to_list(S)),
    {Index, _} = MaxIndex,
    lists:sublist(S, Index).