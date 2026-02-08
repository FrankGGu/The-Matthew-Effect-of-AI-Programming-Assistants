-module(solution).
-export([furthestPointFromOrigin/1]).

furthestPointFromOrigin(Moves) ->
    {FinalPos, FinalWildcards} = lists:foldl(
        fun(Move, {Pos, Wildcards}) ->
            case Move of
                $L -> {Pos - 1, Wildcards};
                $R -> {Pos + 1, Wildcards};
                $_ -> {Pos, Wildcards + 1}
            end
        end,
        {0, 0},
        Moves
    ),
    abs(FinalPos + FinalWildcards) max abs(FinalPos - FinalWildcards).