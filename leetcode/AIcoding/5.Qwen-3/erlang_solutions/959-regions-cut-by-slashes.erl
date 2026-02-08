-module(regions_cut_by_slashes).
-export([regions_cuted_by_slashes/1]).

regions_cuted_by_slashes(Grid) ->
    N = length(Grid),
    Size = N * 3,
    Parent = array:new(Size * Size, {default, 0}),
    init_parent(Parent, Size),
    connect(Parent, Grid, N),
    count_components(Parent, Size).

init_parent(Parent, Size) ->
    init_parent(Parent, 0, Size * Size - 1).

init_parent(Parent, I, Max) when I > Max ->
    Parent;
init_parent(Parent, I, Max) ->
    Parent1 = array:set(I, I, Parent),
    init_parent(Parent1, I + 1, Max).

find(Parent, X) ->
    case array:get(X, Parent) of
        X -> X;
        P -> find(Parent, P)
    end.

union(Parent, X, Y) ->
    PX = find(Parent, X),
    PY = find(Parent, Y),
    if
        PX /= PY -> array:set(PY, PX, Parent);
        true -> Parent
    end.

connect(Parent, Grid, N) ->
    connect(Parent, Grid, N, 0, 0).

connect(Parent, Grid, N, I, J) when I >= N ->
    Parent;
connect(Parent, Grid, N, I, J) when J >= N ->
    connect(Parent, Grid, N, I + 1, 0);
connect(Parent, Grid, N, I, J) ->
    Cell = lists:nth(I + 1, Grid),
    C = string:at(Cell, J),
    case C of
        $/ ->
            A = (I * 3 + 0) * 3 + J * 3 + 2,
            B = (I * 3 + 2) * 3 + J * 3 + 0,
            Parent1 = union(Parent, A, B),
            connect(Parent1, Grid, N, I, J + 1);
        $\ ->
            A = (I * 3 + 0) * 3 + J * 3 + 0,
            B = (I * 3 + 2) * 3 + J * 3 + 2,
            Parent1 = union(Parent, A, B),
            connect(Parent1, Grid, N, I, J + 1);
        _ ->
            A = (I * 3 + 0) * 3 + J * 3 + 0,
            B = (I * 3 + 0) * 3 + J * 3 + 1,
            Parent1 = union(Parent, A, B),
            A1 = (I * 3 + 0) * 3 + J * 3 + 1,
            B1 = (I * 3 + 0) * 3 + J * 3 + 2,
            Parent2 = union(Parent1, A1, B1),
            A2 = (I * 3 + 1) * 3 + J * 3 + 0,
            B2 = (I * 3 + 1) * 3 + J * 3 + 1,
            Parent3 = union(Parent2, A2, B2),
            A3 = (I * 3 + 1) * 3 + J * 3 + 1,
            B3 = (I * 3 + 1) * 3 + J * 3 + 2,
            Parent4 = union(Parent3, A3, B3),
            A4 = (I * 3 + 2) * 3 + J * 3 + 0,
            B4 = (I * 3 + 2) * 3 + J * 3 + 1,
            Parent5 = union(Parent4, A4, B4),
            A5 = (I * 3 + 2) * 3 + J * 3 + 1,
            B5 = (I * 3 + 2) * 3 + J * 3 + 2,
            Parent6 = union(Parent5, A5, B5),
            connect(Parent6, Grid, N, I, J + 1)
    end.

count_components(Parent, Size) ->
    count_components(Parent, 0, Size * Size - 1, 0).

count_components(Parent, I, Max, Count) when I > Max ->
    Count;
count_components(Parent, I, Max, Count) ->
    case find(Parent, I) of
        I -> count_components(Parent, I + 1, Max, Count + 1);
        _ -> count_components(Parent, I + 1, Max, Count)
    end.