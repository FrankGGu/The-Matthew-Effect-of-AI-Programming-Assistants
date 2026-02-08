-module(solution).
-export([find_max_value_of_equation/2]).

find_max_value_of_equation(Points, K) ->
    MaxValue = lists:foldl(fun({x, y}, {Queue, Max}) ->
        Queue1 = queue:in({x, y}, Queue),
        Queue2 = queue:out(Queue1),
        case Queue2 of
            {value, {X1, Y1}, Queue3} ->
                NewMax = MaxMax(Y1 - X1 + y + K, Max),
                {Queue3, NewMax};
            _ ->
                {Queue1, Max}
        end
    end, {queue:new(), -1 div 0}, Points),
    element(2, MaxValue).

MaxMax(A, B) when A > B -> A;
MaxMax(A, B) -> B.