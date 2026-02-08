-module(couples_holding_hands).
-export([min_swaps_couples/1]).

min_swaps_couples(Couples) ->
    N = length(Couples),
    Parent = array:new(N, {default, 0}),
    init_parent(Parent),
    for(0, N-1, fun(I) -> 
        A = lists:nth(I+1, Couples),
        B = lists:nth(I+2, Couples),
        union(Parent, A, B)
    end),
    Swaps = 0,
    for(0, N-1, fun(I) -> 
        A = lists:nth(I+1, Couples),
        B = lists:nth(I+2, Couples),
        if
            find(Parent, A) /= find(Parent, B) -> 
                Swaps + 1;
            true -> 
                Swaps
        end
    end).

init_parent(Parent) ->
    for(0, array:size(Parent)-1, fun(I) -> 
        array:set(I, I, Parent)
    end).

find(Parent, X) ->
    case array:get(X, Parent) of
        X -> X;
        P -> find(Parent, array:get(P, Parent))
    end.

union(Parent, X, Y) ->
    PX = find(Parent, X),
    PY = find(Parent, Y),
    if
        PX /= PY -> array:set(PX, PY, Parent);
        true -> Parent
    end.

for(Start, End, Fun) when Start > End -> ok;
for(Start, End, Fun) -> 
    Fun(Start),
    for(Start+1, End, Fun).