-spec count_students(Students :: [integer()], Sandwiches :: [integer()]) -> integer().
count_students(Students, Sandwiches) ->
    count_students(Students, Sandwiches, 0).

count_students([], _, Count) -> Count;
count_students(Students, [], Count) -> Count + length(Students);
count_students([S | StudentsRest], [S | SandwichesRest], Count) ->
    count_students(StudentsRest, SandwichesRest, Count);
count_students(Students, [S | SandwichesRest], Count) ->
    case lists:member(S, Students) of
        true -> count_students(Students ++ [hd(Students)], [S | SandwichesRest], Count);
        false -> Count + length(Students)
    end.