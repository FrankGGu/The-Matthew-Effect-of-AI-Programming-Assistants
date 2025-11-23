-module(gcd_sort).
-export([gcd_sort/1]).

gcd_sort(Array) ->
    N = length(Array),
    Parent = array:new(N, {default, 0}),
    for(0, N-1, fun(I) -> array:set(I, I, Parent) end),
    for(1, max_val(Array), fun(V) -> 
        for(V, max_val(Array), fun(U) -> 
            if U rem V == 0 -> 
                Union(Parent, V-1, U-1);
            true -> ok
            end
        end)
    end),
    Sorted = lists:sort(Array),
    lists:all(fun(I) -> find(Parent, I-1) == find(Parent, Sorted[I]-1) end, lists:seq(0, N-1)).

max_val(Array) ->
    lists:max(Array).

find(Parent, X) ->
    case array:get(X, Parent) of
        X -> X;
        P -> find(Parent, P)
    end.

union(Parent, X, Y) ->
    PX = find(Parent, X),
    PY = find(Parent, Y),
    if PX /= PY -> array:set(PY, PX, Parent);
       true -> Parent
    end.

for(Start, End, Fun) when Start =< End -> Fun(Start), for(Start+1, End, Fun);
for(_, _, _) -> ok.