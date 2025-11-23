-spec three_equal_parts(Arr :: [integer()]) -> [integer()].
three_equal_parts(Arr) ->
    Ones = lists:sum(Arr),
    N = length(Arr),
    if
        Ones rem 3 =/= 0 -> [-1, -1];
        Ones =:= 0 -> [0, N - 1];
        true ->
            Target = Ones div 3,
            I1 = find_index(Arr, 1, 1),
            J1 = find_index(Arr, 1, Target),
            I2 = find_index(Arr, J1 + 1, 1),
            J2 = find_index(Arr, I2, Target),
            I3 = find_index(Arr, J2 + 1, 1),
            J3 = find_index(Arr, I3, Target),
            TailZeros = N - J3 - 1,
            if
                J1 + TailZeros >= I2 orelse J2 + TailZeros >= I3 -> [-1, -1];
                true ->
                    Part1 = lists:sublist(Arr, I1, J1 - I1 + 1 + TailZeros),
                    Part2 = lists:sublist(Arr, I2, J2 - I2 + 1 + TailZeros),
                    Part3 = lists:sublist(Arr, I3, J3 - I3 + 1 + TailZeros),
                    if
                        Part1 =:= Part2 andalso Part2 =:= Part3 -> [J1 + TailZeros, J2 + TailZeros + 1];
                        true -> [-1, -1]
                    end
            end
    end.

find_index(Arr, Start, Count) ->
    find_index(Arr, Start, Count, 0).

find_index(_, _, 0, Index) -> Index - 1;
find_index([], _, _, _) -> -1;
find_index([H | T], Start, Count, Index) when Index + 1 >= Start ->
    if
        H =:= 1 -> find_index(T, Start, Count - 1, Index + 1);
        true -> find_index(T, Start, Count, Index + 1)
    end;
find_index([_ | T], Start, Count, Index) ->
    find_index(T, Start, Count, Index + 1).