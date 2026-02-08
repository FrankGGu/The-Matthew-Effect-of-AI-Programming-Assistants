-spec triangle_number([integer()]) -> integer().
triangle_number(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A =< B end, Nums),
    Len = length(Sorted),
    Count = 0,
    triangle_number(Sorted, Len, Count).

triangle_number(Sorted, Len, Count) when Len < 3 ->
    Count;
triangle_number(Sorted, Len, Count) ->
    K = Len - 1,
    I = 0,
    J = K - 1,
    NewCount = find_triangles(Sorted, I, J, K, Count),
    triangle_number(lists:sublist(Sorted, Len - 1), Len - 1, NewCount).

find_triangles(Sorted, I, J, K, Count) when I < J ->
    A = lists:nth(I + 1, Sorted),
    B = lists:nth(J + 1, Sorted),
    C = lists:nth(K + 1, Sorted),
    if
        A + B > C ->
            NewCount = Count + (J - I),
            find_triangles(Sorted, I, J - 1, K, NewCount);
        true ->
            find_triangles(Sorted, I + 1, J, K, Count)
    end;
find_triangles(_, _, _, _, Count) ->
    Count.