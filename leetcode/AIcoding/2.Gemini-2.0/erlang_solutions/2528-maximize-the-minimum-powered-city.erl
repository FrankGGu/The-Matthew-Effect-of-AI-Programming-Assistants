-module(maximize_minimum_powered_city).
-export([max_power/2]).

max_power(stations, r) ->
    max_power(stations, r, 0, lists:sum(stations)).

max_power(Stations, R, Low, High) ->
    case Low + 1 >= High of
        true ->
            case check(Stations, R, High) of
                true -> High;
                false -> Low
            end;
        false ->
            Mid = (Low + High) div 2,
            case check(Stations, R, Mid) of
                true -> max_power(Stations, R, Mid, High);
                false -> max_power(Stations, R, Low, Mid)
            end
    end.

check(Stations, R, P) ->
    N = length(Stations),
    Acc = lists:duplicate(N, 0),
    check(Stations, R, P, Acc, 0, 0).

check(_Stations, _R, _P, _Acc, N, _) when N > length(_Stations)-1 ->
    true;
check(Stations, R, P, Acc, I, CurrentSum) ->
    CurrentSum2 = CurrentSum - get_acc(Acc, I - R - 1),
    Need = P - (element(I+1, Stations) + CurrentSum2),
    case Need =< 0 of
        true ->
            check(Stations, R, P, Acc, I + 1, CurrentSum2);
        false ->
            case Need > length(Stations) * 10^10 of
                true -> false;
                false ->
                    check(Stations, R, P, set_acc(Acc, I + R, Need), I + 1, CurrentSum2 + Need)
            end
    end.

get_acc(Acc, Index) ->
    try
        element(Index + 1, Acc)
    catch
        _:_ -> 0
    end.

set_acc(Acc, Index, Value) ->
    lists:nth(Index + 1, lists:map(fun(X, I) ->
                                          case I =:= Index + 1 of
                                              true -> Value;
                                              false -> X
                                          end
                                  end, Acc, lists:seq(1, length(Acc)))) .