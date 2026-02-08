-spec candy(Ratings :: [integer()]) -> integer().
candy(Ratings) ->
    N = length(Ratings),
    Candies1 = lists:duplicate(N, 1),
    Candies2 = left_to_right(Ratings, Candies1, N),
    right_to_left(Ratings, Candies2, N).

left_to_right([], Candies, _) -> Candies;
left_to_right([_], Candies, _) -> Candies;
left_to_right([_ | Tail], [C1, C2 | Rest], N) when C1 < C2 ->
    left_to_right(Tail, [C1 + 1, C2 | Rest], N);
left_to_right([_ | Tail], Candies, N) ->
    left_to_right(Tail, Candies, N).

right_to_left([], Candies, _) -> Candies;
right_to_left([_], Candies, _) -> Candies;
right_to_left([_ | Tail], [C1, C2 | Rest], N) when C1 < C2 ->
    right_to_left(Tail, [C1 + 1, C2 | Rest], N);
right_to_left([_ | Tail], Candies, N) ->
    right_to_left(Tail, Candies, N).
