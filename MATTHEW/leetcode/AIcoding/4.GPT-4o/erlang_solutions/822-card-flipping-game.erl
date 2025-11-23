-module(solution).
-export([flip/1]).

flip(Cards) ->
    Unique = lists:usort(Cards),
    {Min, Max} = lists:min_max(Unique),
    UniqueCards = lists:filter(fun(X) -> X =/= Min andalso X =/= Max end, Unique),
    case UniqueCards of
        [] -> Min + 1;
        _ -> lists:min(UniqueCards)
    end.