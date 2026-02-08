-module(minimum_mountain_triplets).
-export([minimum_sum/1]).

minimum_sum(Nums) ->
  N = length(Nums),
  {Left, Right} = precompute(Nums, N),
  minimum_sum_helper(Nums, N, Left, Right, infinity).

precompute(Nums, N) ->
  Left = lists:foldl(fun(I, Acc) ->
                         case I of
                           1 ->
                             [infinity | Acc];
                           _ ->
                             Prev = lists:nth(I - 1, Nums),
                             MinVal = lists:nth(I - 2, Acc),
                             case Prev < MinVal of
                               true ->
                                 [Prev | Acc];
                               false ->
                                 [MinVal | Acc]
                             end
                         end
                       end, [], lists:seq(1, N)),
  Right = lists:foldl(fun(I, Acc) ->
                          case I of
                            N ->
                              [infinity | Acc];
                            _ ->
                              Prev = lists:nth(N - I + 1, Nums),
                              MinVal = lists:nth(I - 2, Acc),
                              case Prev < MinVal of
                                true ->
                                  [Prev | Acc];
                                false ->
                                  [MinVal | Acc]
                              end
                          end
                        end, [], lists:seq(1, N)),
  {lists:reverse(Left), lists:reverse(Right)}.

minimum_sum_helper(Nums, N, Left, Right, MinSum) ->
  lists:foldl(fun(I, Acc) ->
                  case I of
                    1 ->
                      Acc;
                    N ->
                      Acc;
                    _ ->
                      L = lists:nth(I - 1, Left),
                      R = lists:nth(I - 1, Right),
                      M = lists:nth(I, Nums),
                      case (L < M) and (R < M) of
                        true ->
                          NewSum = L + M + R,
                          min(Acc, NewSum);
                        false ->
                          Acc
                      end
                  end
                end, MinSum, lists:seq(1, N)).