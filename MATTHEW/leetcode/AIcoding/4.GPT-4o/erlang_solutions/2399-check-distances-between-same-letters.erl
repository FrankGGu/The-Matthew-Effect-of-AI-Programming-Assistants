-module(solution).
-export([check_distances/2]).

check_distances(S, D) ->
    check_distances(S, D, #{}).

check_distances([], _, _) -> true;
check_distances([H | T], D, Seen) ->
    case maps:find(H, Seen) of
        error ->
            check_distances(T, D, maps:put(H, length(T) + 1, Seen));
        {ok, Pos} ->
            Dist = length(T) + 1 - Pos,
            if
                Dist =:= maps:get(H, D) -> check_distances(T, D, Seen);
                true -> false
            end
    end.