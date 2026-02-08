-module(solution).
-export([length_of_longest_subarray/1]).

length_of_longest_subarray([]) -> 0;
length_of_longest_subarray([_]) -> 1;
length_of_longest_subarray(Arr) ->
    MaxLen = length_of_longest_subarray(Arr, 1, 1, 1),
    MaxLen.

length_of_longest_subarray([], _CurrentLen, _MaxLen, _Direction) -> 
    max(_CurrentLen, _MaxLen);
length_of_longest_subarray([_], _CurrentLen, _MaxLen, _Direction) -> 
    max(_CurrentLen, _MaxLen);
length_of_longest_subarray([H1, H2 | T], CurrentLen, MaxLen, Direction) ->
    if
        H2 > H1 ->
            NewDirection = 1,
            if
                Direction == 1 ->
                    length_of_longest_subarray([H2 | T], CurrentLen + 1, max(CurrentLen + 1, MaxLen), NewDirection);
                true ->
                    length_of_longest_subarray([H2 | T], 2, max(2, MaxLen), NewDirection)
            end;
        H2 < H1 ->
            NewDirection = -1,
            if
                Direction == -1 ->
                    length_of_longest_subarray([H2 | T], CurrentLen + 1, max(CurrentLen + 1, MaxLen), NewDirection);
                true ->
                    length_of_longest_subarray([H2 | T], 2, max(2, MaxLen), NewDirection)
            end;
        true ->
            length_of_longest_subarray([H2 | T], 1, max(1, MaxLen), 0)
    end.