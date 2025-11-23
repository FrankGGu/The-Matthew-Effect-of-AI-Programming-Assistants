-module(solution).
-export([fillCups/1]).

fillCups([A, B, C]) ->
    Max = lists:max([A, B, C]),
    Sum = A + B + C,
    case Sum >= 2 * Max of
        true -> (Sum + 1) div 2;
        false -> Max
    end.