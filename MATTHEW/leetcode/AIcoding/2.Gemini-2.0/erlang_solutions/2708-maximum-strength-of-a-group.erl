-module(maximum_strength).
-export([maximum_strength/1]).

maximum_strength(Nums) ->
  Sorted = lists:sort(Nums),
  case Sorted of
    [] -> 0;
    [0] -> 0;
    _ ->
      case lists:member(0, Sorted) of
        true ->
          case lists:length(Sorted) of
            1 -> 0;
            _ ->
              NonZeros = lists:filter(fun(X) -> X /= 0 end, Sorted),
              case NonZeros of
                [] -> 0;
                _ ->
                  lists:foldl(fun(X, Acc) -> X * Acc end, 1, NonZeros)
              end
          end;
        false ->
          lists:foldl(fun(X, Acc) -> X * Acc end, 1, Sorted)
      end
  end.