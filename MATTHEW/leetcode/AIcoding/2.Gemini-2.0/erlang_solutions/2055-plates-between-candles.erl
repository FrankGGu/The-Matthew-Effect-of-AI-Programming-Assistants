-module(plates_between_candles).
-export([plates_between_candles/2]).

plates_between_candles(S, Queries) ->
    String = string:to_list(S),
    N = length(String),
    LeftCandle = lists:foldl(fun(I, Acc) ->
                                    case lists:nth(I, String) of
                                        $| -> [I | Acc];
                                        _ -> Acc
                                    end
                                end, [], lists:seq(1, N)),
    RightCandle = lists:reverse(lists:foldl(fun(I, Acc) ->
                                                case lists:nth(I, String) of
                                                    $| -> [I | Acc];
                                                    _ -> Acc
                                                end
                                            end, [], lists:seq(1, N))),

    lists:map(fun({Left, Right}) ->
                  LeftIndex = lists:foldl(fun(CandleIndex, Acc) ->
                                              case CandleIndex >= Left of
                                                  true ->
                                                      case Acc of
                                                          none -> CandleIndex;
                                                          _ -> Acc
                                                      end;
                                                  false ->
                                                      Acc
                                              end
                                          end, none, LeftCandle),
                  RightIndex = lists:foldr(fun(CandleIndex, Acc) ->
                                               case CandleIndex =< Right of
                                                   true ->
                                                       case Acc of
                                                           none -> CandleIndex;
                                                           _ -> Acc
                                                       end;
                                                   false ->
                                                       Acc
                                               end
                                           end, none, RightCandle),

                  case {LeftIndex, RightIndex} of
                      {none, _} -> 0;
                      {_, none} -> 0;
                      {L, R} when L >= R -> 0;
                      {L, R} ->
                          Length = R - L - 1,
                          if
                              Length > 0 ->
                                  Count = lists:foldl(fun(I, Acc) ->
                                                          case lists:nth(I, String) of
                                                              $* -> Acc + 1;
                                                              _ -> Acc
                                                          end
                                                      end, 0, lists:seq(L + 1, R - 1)),
                                  Count;
                              true -> 0
                          end
                  end
              end, Queries).