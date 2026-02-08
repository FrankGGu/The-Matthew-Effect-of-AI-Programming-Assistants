-module(solution).
-export([brace_expansion_ii/1]).

brace_expansion_ii(S) ->
    lists:sort(sets:to_list(expand(S))).

expand(S) ->
    case lists:foldl(fun(C, {Cur, Acc}) ->
        case C of
            ?LEFT_BRACE ->
                {Cur, Acc};
            ?RIGHT_BRACE ->
                {lists:reverse(Acc), []};
            _ ->
                {Cur ++ [C], Acc}
        end
    end, {[], []}, string:to_list(S)) of
        {[], Acc} -> sets:from_list([lists:flatten(Acc)]);
        {Cur, Acc} -> sets:from_list([lists:flatten(Cur) | lists:flatten(Acc)])
    end.

-define(LEFT_BRACE, $\{).
-define(RIGHT_BRACE, $\}).