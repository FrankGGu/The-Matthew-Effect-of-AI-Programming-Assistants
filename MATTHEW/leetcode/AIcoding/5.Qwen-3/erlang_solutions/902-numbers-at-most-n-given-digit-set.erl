-module(solution).
-export([num_digits/1]).

num_digits(DigitSet) ->
    num_digits(DigitSet, 0, 0).

num_digits([], _, _) ->
    0;
num_digits([H|T], Index, Count) ->
    case H of
        0 -> 
            num_digits(T, Index + 1, Count);
        _ ->
            if
                Index == 0 ->
                    NewCount = Count + 1,
                    num_digits(T, Index + 1, NewCount);
                true ->
                    NewCount = Count + 1,
                    num_digits(T, Index + 1, NewCount)
            end
    end.