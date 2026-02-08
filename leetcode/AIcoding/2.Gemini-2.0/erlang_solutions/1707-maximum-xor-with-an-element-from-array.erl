-module(maximum_xor).
-export([maximizeXor/2]).

maximizeXor(Nums, Queries) ->
  SortedNums = lists:sort(Nums),
  [maximizeXorHelper(SortedNums, Q) || Q <- Queries].

maximizeXorHelper(SortedNums, [Value, Limit]) ->
  maximizeXorHelper(SortedNums, Value, Limit, -1).

maximizeXorHelper([], _Value, _Limit, MaxXor) ->
  MaxXor;
maximizeXorHelper(SortedNums, Value, Limit, MaxXor) ->
  case SortedNums of
    [] ->
      MaxXor;
    [H|T] ->
      case H =< Limit of
        true ->
          NewXor = Value bxor H,
          case NewXor > MaxXor of
            true ->
              maximizeXorHelper(T, Value, Limit, NewXor);
            false ->
              maximizeXorHelper(T, Value, Limit, MaxXor)
          end;
        false ->
          MaxXor
      end
  end.