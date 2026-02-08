-module(solution).
-export([max_forts_that_can_be_captured/1]).

max_forts_that_can_be_captured(Forts) ->
    {MaxCaptured, _, _} = lists:foldl(
        fun(Fort, {AccMax, LastFortVal, EmptyCount}) ->
            case Fort of
                -1 ->
                    case LastFortVal of
                        undefined ->
                            {AccMax, LastFortVal, EmptyCount};
                        _ ->
                            {AccMax, LastFortVal, EmptyCount + 1}
                    end;
                _ ->
                    case LastFortVal of
                        undefined ->
                            {AccMax, Fort, 0};
                        Fort ->
                            {AccMax, Fort, 0};
                        _ ->
                            {max(AccMax, EmptyCount), Fort, 0}
                    end
            end
        end,
        {0, undefined, 0},
        Forts
    ),
    MaxCaptured.