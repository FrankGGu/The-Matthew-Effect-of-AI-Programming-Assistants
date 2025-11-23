-spec maximum_even_split(FinalSum :: integer()) -> [integer()].
maximum_even_split(FinalSum) when FinalSum rem 2 =/= 0 -> [];
maximum_even_split(FinalSum) ->
    maximum_even_split(FinalSum, 2, []).

maximum_even_split(Remaining, Current, Acc) when Remaining < Current * 2 ->
    [Remaining | Acc];
maximum_even_split(Remaining, Current, Acc) ->
    maximum_even_split(Remaining - Current, Current + 2, [Current | Acc]).