-module(find_max_fruits).
-export([total_fruit/2]).

total_fruit(Fruits, K) ->
    total_fruit(Fruits, K, 0, 0, 0, []).

total_fruit([], _K, Max, _Start, _Current, _Basket) ->
    Max;
total_fruit([Fruit | Rest], K, Max, Start, Current, Basket) ->
    case lists:member(Fruit, Basket) of
        true ->
            total_fruit(Rest, K, max(Max, Current + 1), Start, Current + 1, Basket);
        false ->
            case length(lists:usort(Basket)) of
                0 ->
                    total_fruit(Rest, K, max(Max, Current + 1), Start, Current + 1, [Fruit | Basket]);
                1 ->
                    total_fruit(Rest, K, max(Max, Current + 1), Start, Current + 1, [Fruit | Basket]);
                2 ->
                    total_fruit(Rest, K, Max, Start + 1, Current, lists:delete(lists:nth(1, Fruits, Start), Basket)),
                    total_fruit([Fruit | Rest], K, max(Max, Current + 1), Start, Current + 1, [Fruit | Basket]);
                _ ->
                    throw(error)
            end
    end.

lists:nth(N, List, Acc) ->
  lists:nth(N, List, Acc, 1).

lists:nth(_N, [], _Acc, _I) ->
  [];
lists:nth(N, [H|T], Acc, I) ->
  case N =:= I of
    true ->
      H;
    false ->
      lists:nth(N, T, Acc, I + 1)
  end.