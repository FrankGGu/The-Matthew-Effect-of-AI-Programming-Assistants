-module(minimum_operations).
-export([make_similar/2]).

make_similar(Nums, Target) ->
  Odds1 = lists:sort([N || N <- Nums, (N rem 2) =:= 1]),
  Evens1 = lists:sort([N || N <- Nums, (N rem 2) =:= 0]),
  Odds2 = lists:sort([N || N <- Target, (N rem 2) =:= 1]),
  Evens2 = lists:sort([N || N <- Target, (N rem 2) =:= 0]),

  OpsOdds = lists:sum([abs(A - B) || {A, B} <- lists:zip(Odds1, Odds2), A > B]) div 2,
  OpsEvens = lists:sum([abs(A - B) || {A, B} <- lists:zip(Evens1, Evens2), A > B]) div 2,

  OpsOdds + OpsEvens.