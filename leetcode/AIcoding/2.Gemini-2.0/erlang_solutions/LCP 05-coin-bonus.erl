-module(coin_bonus).
-export([bonus/1]).

bonus(employees) ->
    N = length(employees),
    Bonuses = lists:duplicate(N, 1),

    % 从左到右遍历
    Bonuses1 = lists:foldl(fun(I, Acc) ->
                                  case I > 1 andalso lists:nth(I, employees) > lists:nth(I-1, employees) of
                                      true ->
                                          lists:nth(I-1, Acc) + 1;
                                      false ->
                                          lists:nth(I, Acc)
                                  end
                              end, Bonuses, lists:seq(2, N)),

    % 从右到左遍历
    Bonuses2 = lists:reverse(lists:foldl(fun(I, Acc) ->
                                              case I < N andalso lists:nth(I, employees) > lists:nth(I+1, employees) of
                                                  true ->
                                                      Max = max(lists:nth(I+1, Acc) + 1, lists:nth(I, Acc));
                                                      lists:nth(I,Acc);
                                                  false ->
                                                      lists:nth(I, Acc)
                                              end
                                          end, lists:reverse(Bonuses1), lists:seq(N-1, -1, 1))),

    lists:sum(lists:zipwith(fun(X,Y) -> max(X,Y) end, Bonuses1, Bonuses2)).