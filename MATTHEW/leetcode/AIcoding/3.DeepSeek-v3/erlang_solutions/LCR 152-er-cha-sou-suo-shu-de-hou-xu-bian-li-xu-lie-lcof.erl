-spec verify_postorder(Postorder :: [integer()]) -> boolean().
verify_postorder(Postorder) ->
    verify(Postorder, -infinity, infinity).

verify([], Min, Max) ->
    true;
verify([Root | Rest], Min, Max) when Root >= Min, Root =< Max ->
    {Left, Right} = split(Rest, Root),
    verify(Left, Min, Root) andalso verify(Right, Root, Max);
verify(_, _, _) ->
    false.

split(List, Pivot) ->
    split(List, Pivot, [], []).

split([], _, Left, Right) ->
    {Left, Right};
split([H | T], Pivot, Left, Right) when H < Pivot ->
    split(T, Pivot, [H | Left], Right);
split([H | T], Pivot, Left, Right) ->
    split(T, Pivot, Left, [H | Right]).