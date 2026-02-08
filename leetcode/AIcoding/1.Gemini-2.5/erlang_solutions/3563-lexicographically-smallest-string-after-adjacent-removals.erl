-module(solution).
-export([removeDuplicates/1]).

removeDuplicates(S) ->
    ResultStack = lists:foldl(
        fun(Char, Acc) ->
            case Acc of
                [] ->
                    [Char];
                [Head | Tail] when Char == Head ->
                    Tail;
                _ ->
                    [Char | Acc]
            end
        end,
        [],
        S
    ),
    lists:reverse(ResultStack).