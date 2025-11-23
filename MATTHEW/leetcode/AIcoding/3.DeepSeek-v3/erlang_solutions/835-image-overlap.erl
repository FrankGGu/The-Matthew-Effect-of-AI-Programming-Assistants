-spec largest_overlap(Img1 :: [[integer()]], Img2 :: [[integer()]]) -> integer().
largest_overlap(Img1, Img2) ->
    N = length(Img1),
    Ones1 = [{I, J} || I <- lists:seq(0, N-1), J <- lists:seq(0, N-1), lists:nth(I+1, lists:nth(J+1, Img1)) =:= 1],
    Ones2 = [{I, J} || I <- lists:seq(0, N-1), J <- lists:seq(0, N-1), lists:nth(I+1, lists:nth(J+1, Img2)) =:= 1],
    Counts = maps:new(),
    Counts1 = lists:foldl(fun({X1, Y1}, Acc) ->
        lists:foldl(fun({X2, Y2}, AccInner) ->
            Delta = {X1 - X2, Y1 - Y2},
            maps:update_with(Delta, fun(V) -> V + 1 end, 1, AccInner)
        end, Acc, Ones2)
    end, Counts, Ones1),
    case maps:size(Counts1) of
        0 -> 0;
        _ -> lists:max(maps:values(Counts1))
    end.