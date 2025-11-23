-module(solution).
-export([can_construct/2]).

can_construct(RansomNote, Magazine) ->
    MagazineCounts = lists:foldl(
        fun(Char, AccMap) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        Magazine
    ),
    check_ransom_note(RansomNote, MagazineCounts).

check_ransom_note([], _MagazineCounts) ->
    true;
check_ransom_note([Char | Rest], MagazineCounts) ->
    case maps:find(Char, MagazineCounts) of
        {ok, Count} when Count > 0 ->
            UpdatedCounts = maps:update(Char, Count - 1, MagazineCounts),
            check_ransom_note(Rest, UpdatedCounts);
        _ ->
            false
    end.