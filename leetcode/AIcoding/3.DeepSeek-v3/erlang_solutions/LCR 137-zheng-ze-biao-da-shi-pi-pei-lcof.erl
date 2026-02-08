-module(solution).
-export([is_match/2]).

is_match(S, P) ->
    is_match(S, P, 0, 0).

is_match([], [], _, _) -> true;
is_match(_, [], _, _) -> false;
is_match([], [C | Rest], _, _) when C =/= $* -> false;
is_match([], [$* | Rest], _, _) -> is_match([], Rest, 0, 0);
is_match([SC | SRest], [PC | PRest], SCache, PCache) ->
    case PC of
        $? ->
            is_match(SRest, PRest, 0, 0);
        $* ->
            is_match([SC | SRest], PRest, 0, 0) orelse
            is_match(SRest, [PC | PRest], 0, 0);
        _ ->
            if
                SC =:= PC ->
                    is_match(SRest, PRest, 0, 0);
                true ->
                    false
            end
    end.