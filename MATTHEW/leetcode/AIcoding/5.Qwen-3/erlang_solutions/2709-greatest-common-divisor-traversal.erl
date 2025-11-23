-module(greatest_common_divisor_traversal).
-export([greatest_common_divisor_traversal/1]).

greatest_common_divisor_traversal(Nums) ->
    N = length(Nums),
    Parent = array:new(N, {default, 0}),
    for(I, 0, N-1, fun() -> array:set(I, I, Parent) end),
    for(I, 0, N-1, fun() -> union(Parent, I, get_prime_factors(Nums[I])) end),
    Root = find(Parent, 0),
    for(I, 1, N-1, fun() -> if find(Parent, I) /= Root -> false; true -> true end end).

for(_Start, _End, _Fun) when _Start > _End -> ok;
for(Start, End, Fun) ->
    Fun(),
    for(Start + 1, End, Fun).

find(Parent, X) ->
    case array:get(X, Parent) of
        X -> X;
        P -> find(Parent, P)
    end.

union(Parent, X, Factors) ->
    lists:foreach(fun(F) -> 
        case maps:get(F, #{}, -1) of
            -1 -> maps:put(F, X, #{}); 
            Y -> union(Parent, X, Y)
        end
    end, Factors).

get_prime_factors(N) ->
    get_prime_factors(N, 2, []).

get_prime_factors(1, _, Acc) -> Acc;
get_prime_factors(N, D, Acc) when N rem D == 0 ->
    get_prime_factors(N div D, D, [D | Acc]);
get_prime_factors(N, D, Acc) ->
    get_prime_factors(N, D + 1, Acc).