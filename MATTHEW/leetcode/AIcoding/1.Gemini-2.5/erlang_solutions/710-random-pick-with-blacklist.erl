-module(solution).
-export([init/2, pick/1]).

init(N, Blacklist) ->
    rand:seed(exs1024),

    M = N - length(Blacklist),
    BlacklistSet = gb_sets:from_list(Blacklist),

    MapBlacklist = build_map_blacklist(M, N - 1, Blacklist, BlacklistSet, #{}).

    {ok, #{m => M, map_blacklist => MapBlacklist}}.

pick(#{m := M, map_blacklist := MapBlacklist}) ->
    Idx = rand:uniform(M) - 1,

    case maps:find(Idx, MapBlacklist) of
        {ok, MappedValue} ->
            {ok, MappedValue};
        error ->
            {ok, Idx}
    end.

build_map_blacklist(M, CurrentLastValid, [], _BlacklistSet, AccMap) ->
    AccMap;
build_map_blacklist(M, CurrentLastValid, [B | Rest], BlacklistSet, AccMap) ->
    if B < M ->
        Replacement = find_replacement(CurrentLastValid, BlacklistSet),
        NewAccMap = maps:put(B, Replacement, AccMap),
        build_map_blacklist(M, Replacement - 1, Rest, BlacklistSet, NewAccMap);
    true ->
        build_map_blacklist(M, CurrentLastValid, Rest, BlacklistSet, AccMap)
    end.

find_replacement(CurrentLastValid, BlacklistSet) ->
    if gb_sets:is_member(CurrentLastValid, BlacklistSet) ->
        find_replacement(CurrentLastValid - 1, BlacklistSet);
    true ->
        CurrentLastValid
    end.