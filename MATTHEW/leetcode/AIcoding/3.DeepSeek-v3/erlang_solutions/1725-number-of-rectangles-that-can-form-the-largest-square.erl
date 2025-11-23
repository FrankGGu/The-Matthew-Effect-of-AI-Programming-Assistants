-spec count_good_rectangles(Rectangles :: [[integer()]]) -> integer().
count_good_rectangles(Rectangles) ->
    MaxLen = lists:max([min(W, H) || [W, H] <- Rectangles]),
    length([1 || [W, H] <- Rectangles, min(W, H) == MaxLen]).