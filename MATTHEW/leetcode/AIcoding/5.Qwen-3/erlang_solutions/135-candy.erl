-module(candy).
-export([candy/1]).

candy(Ratings) ->
    Len = length(Ratings),
    if
        Len == 0 -> 0;
        true ->
            Left = lists:seq(1, Len),
            Right = lists:seq(1, Len),
            Left2 = left_pass(Ratings, Left, 1),
            Right2 = right_pass(Ratings, Right, Len - 1),
            lists:zipwith(fun(A, B) -> A + B end, Left2, Right2)
    end.

left_pass(_, Acc, -1) -> Acc;
left_pass(Ratings, Acc, I) ->
    case I of
        0 -> left_pass(Ratings, Acc, I - 1);
        _ ->
            Prev = lists:nth(I, Ratings),
            Current = lists:nth(I + 1, Ratings),
            if
                Current > Prev ->
                    NewAcc = lists:sublist(Acc, I) ++ [lists:nth(I, Acc) + 1] ++ lists:nthtail(I + 1, Acc);
                true ->
                    NewAcc = lists:sublist(Acc, I) ++ [1] ++ lists:nthtail(I + 1, Acc)
            end,
            left_pass(Ratings, NewAcc, I - 1)
    end.

right_pass(_, Acc, Len) -> Acc;
right_pass(Ratings, Acc, I) ->
    case I of
        Len -> right_pass(Ratings, Acc, I - 1);
        _ ->
            Next = lists:nth(I + 1, Ratings),
            Current = lists:nth(I, Ratings),
            if
                Current > Next ->
                    NewAcc = lists:sublist(Acc, I) ++ [lists:nth(I, Acc) + 1] ++ lists:nthtail(I + 1, Acc);
                true ->
                    NewAcc = lists:sublist(Acc, I) ++ [1] ++ lists:nthtail(I + 1, Acc)
            end,
            right_pass(Ratings, NewAcc, I - 1)
    end.