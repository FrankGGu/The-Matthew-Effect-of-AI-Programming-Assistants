-spec is_covered(Ranges :: [[integer()]], Left :: integer(), Right :: integer()) -> boolean().
is_covered(Ranges, Left, Right) ->
    Checked = lists:foldl(fun([Start, End], Acc) ->
                                  lists:seq(Start, End) ++ Acc
                          end, [], Ranges),
    lists:all(fun(X) -> lists:member(X, Checked) end, lists:seq(Left, Right)).