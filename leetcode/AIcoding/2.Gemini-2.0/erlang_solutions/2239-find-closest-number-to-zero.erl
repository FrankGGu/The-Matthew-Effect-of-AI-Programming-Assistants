-module(closest_to_zero).
-export([find_closest/1]).

find_closest(Nums) ->
  lists:foldl(fun(Num, Acc) ->
                  case Acc of
                    undefined ->
                      Num;
                    Closest ->
                      DiffNum = abs(Num),
                      DiffClosest = abs(Closest),
                      case DiffNum < DiffClosest of
                        true ->
                          Num;
                        false ->
                          case DiffNum == DiffClosest of
                            true ->
                              max(Num, Closest);
                            false ->
                              Closest
                          end
                      end
                  end
              end, undefined, Nums).