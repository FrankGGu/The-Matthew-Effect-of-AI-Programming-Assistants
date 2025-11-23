%% -spec maximal_rectangle(Matrix :: [[char()]]) -> integer().
maximal_rectangle(Matrix) ->
    maximal_rectangle(Matrix, 0, []).

maximal_rectangle([], Max, _) -> Max;
maximal_rectangle([Row | Rest], Max, Heights) ->
    NewHeights = calculate_heights(Row, Heights),
    MaxHeight = largest_rectangle_area(NewHeights),
    maximal_rectangle(Rest, max(Max, MaxHeight), NewHeights).

calculate_heights([], []) -> [];
calculate_heights([C | Cs], [H | Rest]) when C =:= $1 -> [H + 1 | calculate_heights(Cs, Rest)];
calculate_heights([C | Cs], [_ | Rest]) when C =:= $0 -> [0 | calculate_heights(Cs, Rest)].

largest_rectangle_area(Heights) -> largest_rectangle_area(Heights, [], 0).

largest_rectangle_area([], Stack, MaxArea) -> MaxArea;
largest_rectangle_area([H | T], Stack, MaxArea) ->
    NewStack = push_stack(Stack, H, 0),
    largest_rectangle_area(T, NewStack, MaxArea).

push_stack([], H, MaxArea) -> [H];
push_stack([Top | Rest], H, MaxArea) when Top < H -> [Top | push_stack(Rest, H, MaxArea)];
push_stack([Top | Rest], H, MaxArea) when Top >= H -> [H | push_stack(Rest, H, MaxArea)].
