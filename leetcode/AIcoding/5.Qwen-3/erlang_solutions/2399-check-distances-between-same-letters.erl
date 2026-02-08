-module(solution).
-export([check_distances/1]).

check_distances(S) ->
    Map = maps:from_list([{Char, lists:seq(0, erlang:length(S)-1)} || {Char, _} <- lists:zip(S, lists:seq(1, erlang:length(S)))]),
    check_distances(S, Map).

check_distances([], _) -> true;
check_distances([H|T], Map) ->
    case maps:find(H, Map) of
        {ok, [Pos]} -> check_distances(T, Map);
        {ok, [Pos1, Pos2 | _]} ->
            Dist = abs(Pos1 - Pos2),
            case maps:is_key(Dist, Map) of
                true -> check_distances(T, Map);
                false -> false
            end;
        _ -> check_distances(T, Map)
    end.