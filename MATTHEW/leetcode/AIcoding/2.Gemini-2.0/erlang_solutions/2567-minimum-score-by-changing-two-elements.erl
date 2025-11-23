-module(minimum_score).
-export([minimum_score/1]).

minimum_spec() ->
  [
    {'nums', list(integer()), list(integer())}
  ].

minimum_score(Nums) ->
  lists:sort(Nums),
  Len = length(Nums),
  case Len of
    3 -> 0;
    _ ->
      case Len of
        4 ->
          min(abs(lists:nth(1, Nums) - lists:nth(Len, Nums)), abs(lists:nth(2, Nums) - lists:nth(Len - 1, Nums)));
        _ ->
          min(min(abs(lists:nth(1, Nums) - lists:nth(Len - 2, Nums)), abs(lists:nth(3, Nums) - lists:nth(Len, Nums))), abs(lists:nth(2, Nums) - lists:nth(Len - 1, Nums)))
      end
  end.