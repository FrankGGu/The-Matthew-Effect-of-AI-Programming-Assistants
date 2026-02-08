-module(minimum_elements).
-export([min_elements/3]).

min_elements(Nums, Limit, Goal) ->
  Sum = lists:sum(Nums),
  Diff = abs(Goal - Sum),
  math:ceil(Diff / Limit).