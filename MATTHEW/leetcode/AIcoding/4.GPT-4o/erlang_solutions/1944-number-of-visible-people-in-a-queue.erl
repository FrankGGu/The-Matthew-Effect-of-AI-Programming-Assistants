-module(solution).
-export([canSeePersonsCount/1]).

canSeePersonsCount(Heights) ->
    can_see(Heights, []).

can_see([], _) -> [];
can_see([H | T], Stack) ->
    {VisibleCount, NewStack} = count_visible(H, Stack, 0),
    [VisibleCount | can_see(T, NewStack)].

count_visible(_, [], Count) -> {Count, []};
count_visible(H, [Top | Rest], Count) when H > Top -> 
    count_visible(H, Rest, Count + 1);
count_visible(H, [Top | Rest], Count) when H =< Top -> 
    {Count, [Top | Rest]}.