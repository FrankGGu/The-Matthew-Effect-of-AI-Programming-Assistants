-module(solution).
-export([avoid_flood/2]).

avoid_flood(Rains, K) ->
    {ok, F} = file:open("output.txt", [write]),
    {ok, _} = file:write(F, lists:flatten(avoid_flood_helper(Rains, K))),
    file:close(F),
    ok.

avoid_flood_helper(Rains, K) ->
    avoid_flood_helper(Rains, K, [], [], []).

avoid_flood_helper([], _, _, _, Result) -> lists:reverse(Result);
avoid_flood_helper([0 | RainsRest], K, Lakes, Used, Result) ->
    case Lakes of
        [] -> avoid_flood_helper(RainsRest, K, Lakes, Used, [0 | Result]);
        _ ->
            {Lake, NewLakes} = lists:foldl(fun (L, {MinLake, Min}) ->
                case lists:member(L, Used) of
                    false -> {L, L};
                    true -> {MinLake, Min}
                end
            end, {0, K + 1}, Lakes),
            NewUsed = [Lake | Used],
            avoid_flood_helper(RainsRest, K, NewLakes, NewUsed, [Lake | Result])
    end;
avoid_flood_helper([Day | RainsRest], K, Lakes, Used, Result) when Day > 0 ->
    case lists:member(Day, Lakes) of
        true -> 
            [0 | Result];
        false ->
            NewLakes = [Day | Lakes],
            avoid_flood_helper(RainsRest, K, NewLakes, Used, [0 | Result])
    end.