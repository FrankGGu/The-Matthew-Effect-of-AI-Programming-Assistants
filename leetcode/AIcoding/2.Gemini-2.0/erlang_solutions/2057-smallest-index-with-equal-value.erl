-module(smallest_equal).
-export([smallest_equal/1]).

smallest_equal(Nums) ->
    smallest_equal(Nums, 0).

smallest_equal([], _Index) ->
    -1;
smallest_equal([H|T], Index) ->
    case Index rem 10 =:= H of
        true -> Index;
        false ->
            smallest_equal(T, Index + 1)
    end.