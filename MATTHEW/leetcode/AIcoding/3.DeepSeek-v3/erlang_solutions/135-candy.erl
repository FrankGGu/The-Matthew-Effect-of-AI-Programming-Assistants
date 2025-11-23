-spec candy(Ratings :: [integer()]) -> integer().
candy(Ratings) ->
    N = length(Ratings),
    Candies = lists:duplicate(N, 1),
    Left = left_pass(Ratings, Candies, 1),
    Right = right_pass(Ratings, Left, N - 2),
    lists:sum(Right).

left_pass(_, Candies, N) when N =:= length(Candies) -> Candies;
left_pass(Ratings, Candies, I) ->
    case lists:nth(I + 1, Ratings) > lists:nth(I, Ratings) of
        true ->
            NewCandies = setelement(I + 1, Candies, lists:nth(I, Candies) + 1),
            left_pass(Ratings, NewCandies, I + 1);
        false ->
            left_pass(Ratings, Candies, I + 1)
    end.

right_pass(_, Candies, -1) -> Candies;
right_pass(Ratings, Candies, I) ->
    case lists:nth(I + 1, Ratings) < lists:nth(I, Ratings) of
        true ->
            Current = lists:nth(I, Candies),
            Next = lists:nth(I + 1, Candies),
            NewCandies = setelement(I, Candies, max(Current, Next + 1)),
            right_pass(Ratings, NewCandies, I - 1);
        false ->
            right_pass(Ratings, Candies, I - 1)
    end.