-spec is_valid(S :: unicode:unicode_binary()) -> boolean().
is_valid(S) ->
    is_valid(S, []).

is_valid([], []) -> true;
is_valid([], _) -> false;
is_valid([H | T], Stack) when H == $\( or H == $\{ or H == $\[ ->
    is_valid(T, [H | Stack]);
is_valid([H | T], [Top | Stack]) when H == $\) and Top == $\( -> 
    is_valid(T, Stack);
is_valid([H | T], [Top | Stack]) when H == $\} and Top == $\{ ->
    is_valid(T, Stack);
is_valid([H | T], [Top | Stack]) when H == $\] and Top == $\[ ->
    is_valid(T, Stack);
is_valid(_, _) -> false.
