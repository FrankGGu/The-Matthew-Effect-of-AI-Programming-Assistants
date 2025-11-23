-module(product_recommendation_pairs).
-export([find_pairs/1]).

find_pairs(Purchases) ->
  find_pairs_helper(Purchases, []).

find_pairs_helper([], Acc) ->
  lists:usort([lists:sort(Pair) || Pair <- Acc]);
find_pairs_helper([Purchase | Rest], Acc) ->
  Products = lists:usort(Purchase#purchase.products),
  NewPairs = generate_pairs(Products),
  find_pairs_helper(Rest, Acc ++ NewPairs).

generate_pairs([_]) ->
  [];
generate_pairs([H | T]) ->
  Pairs = [[H, X] || X <- T],
  Pairs ++ generate_pairs(T).