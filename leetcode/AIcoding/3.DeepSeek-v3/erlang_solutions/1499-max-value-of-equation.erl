-spec find_max_value_of_equation(Points :: [[integer()]], K :: integer()) -> integer().
find_max_value_of_equation(Points, K) ->
    Deque = queue:new(),
    Max = -1000000000,
    find_max_value_of_equation(Points, K, Deque, Max).

find_max_value_of_equation([[X, Y] | Rest], K, Deque, Max) ->
    {NewDeque, NewMax} = process_point(X, Y, K, Deque, Max),
    NewDeque1 = add_to_deque(X, Y, NewDeque),
    find_max_value_of_equation(Rest, K, NewDeque1, NewMax);
find_max_value_of_equation([], _, _, Max) ->
    Max.

process_point(X, Y, K, Deque, Max) ->
    case queue:is_empty(Deque) of
        true -> {Deque, Max};
        false ->
            {{value, [X0, Y0]}, Deque1} = queue:peek(Deque),
            if
                X - X0 > K ->
                    process_point(X, Y, K, queue:drop(Deque), Max);
                true ->
                    Current = Y0 + Y + (X - X0),
                    NewMax = max(Max, Current),
                    {Deque, NewMax}
            end
    end.

add_to_deque(X, Y, Deque) ->
    case queue:is_empty(Deque) of
        true -> queue:in([X, Y], Deque);
        false ->
            {{value, [X0, Y0]}, _} = queue:peek(Deque),
            Val = Y - X,
            Val0 = Y0 - X0,
            if
                Val >= Val0 ->
                    NewDeque = queue:drop(Deque),
                    add_to_deque(X, Y, NewDeque);
                true ->
                    case queue:out_r(Deque) of
                        {empty, _} -> queue:in([X, Y], Deque);
                        {{value, [X1, Y1]}, Deque1} ->
                            Val1 = Y1 - X1,
                            if
                                Val >= Val1 ->
                                    add_to_deque(X, Y, Deque1);
                                true ->
                                    queue:in([X, Y], Deque)
                            end
                    end
            end
    end.