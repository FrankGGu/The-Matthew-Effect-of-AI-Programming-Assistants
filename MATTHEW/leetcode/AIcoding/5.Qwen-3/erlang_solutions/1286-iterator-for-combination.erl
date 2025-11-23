-module(combinations).
-export([new/2, next/1, has_next/1]).

-record(iterator, {combs, index}).

new(Chars, K) ->
    Combs = generate_combinations(Chars, K),
    #iterator{combs = Combs, index = 0}.

generate_combinations(Chars, K) ->
    generate_combinations(Chars, K, []).

generate_combinations(_, 0, Acc) ->
    [lists:reverse(Acc)];
generate_combinations([], _, _) ->
    [];
generate_combinations([H|T], K, Acc) ->
    [H | Acc] ++ generate_combinations(T, K-1, [H | Acc]) ++ generate_combinations(T, K, Acc).

next(#iterator{combs = Combs, index = Index}) ->
    lists:nth(Index + 1, Combs).

has_next(#iterator{combs = Combs, index = Index}) ->
    Index + 1 =< length(Combs).