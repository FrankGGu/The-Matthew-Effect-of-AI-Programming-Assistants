-spec max_sales(Sales :: [integer()]) -> integer().
max_sales(Sales) ->
    max_sales(Sales, 0, 0).

max_sales([], _, Max) -> Max;
max_sales([H | T], Current, Max) ->
    NewCurrent = max(H, Current + H),
    NewMax = max(NewCurrent, Max),
    max_sales(T, NewCurrent, NewMax).