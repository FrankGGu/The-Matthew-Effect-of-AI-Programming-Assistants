-module(solution).
-export([maximum_good_people/1]).

maximum_good_people(Statements) ->
    N = length(Statements),
    lists:seq(0, 2#(N - 1)),
    maximum_good_people(Statements, N, 0).

maximum_good_people(_, N, Max) when N < 0 -> Max;
maximum_good_people(Statements, N, Max) ->
    case is_good(N, Statements) of
        true -> maximum_good_people(Statements, N - 1, max(Max, count_good(N, Statements)));
        false -> maximum_good_people(Statements, N - 1, Max)
    end.

is_good(N, Statements) ->
    Good = (N band 1) bsl (N div 1),
    lists:all(fun(I) -> (bitwise_and(Good, (1 bsl I)) /= 0) orelse (Statements(N, I) =:= 1) end, lists:seq(0, length(Statements) - 1)).

count_good(N, Statements) ->
    lists:foldl(fun(I, Acc) -> Acc + ((N band 1) bsl I) end, 0, lists:seq(0, length(Statements) - 1)).