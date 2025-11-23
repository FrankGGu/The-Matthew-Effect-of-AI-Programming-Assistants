-module(solution).
-export([sortString/1]).

sortString(S) ->
    Counts = char_counts(S),
    TotalChars = length(S),
    loop(Counts, TotalChars, []).

char_counts(S) ->
    lists:foldl(fun(C, Acc) ->
                        Index = C - $a,
                        CurrentCount = array:get(Index, Acc),
                        array:set(Index, CurrentCount + 1, Acc)
                end, array:new(26, {default, 0}), S).

loop(Counts, TotalChars, AccResult) ->
    if
        TotalChars == 0 ->
            lists:reverse(AccResult);
        true ->
            {NewCounts1, AccResult1, Added1} = do_increasing_pass(Counts, AccResult),
            TotalChars1 = TotalChars - Added1,
            {NewCounts2, AccResult2, Added2} = do_decreasing_pass(NewCounts1, AccResult1),
            TotalChars2 = TotalChars1 - Added2,
            loop(NewCounts2, TotalChars2, AccResult2)
    end.

do_increasing_pass(Counts, AccResult) ->
    do_increasing_pass_loop(0, Counts, AccResult, 0).

do_increasing_pass_loop(Index, Counts, AccResult, Added) when Index < 26 ->
    Count = array:get(Index, Counts),
    if
        Count > 0 ->
            Char = $a + Index,
            NewCounts = array:set(Index, Count - 1, Counts),
            do_increasing_pass_loop(Index + 1, NewCounts, [Char | AccResult], Added + 1);
        true ->
            do_increasing_pass_loop(Index + 1, Counts, AccResult, Added)
    end;
do_increasing_pass_loop(26, Counts, AccResult, Added) ->
    {Counts, AccResult, Added}.

do_decreasing_pass(Counts, AccResult) ->
    do_decreasing_pass_loop(25, Counts, AccResult, 0).

do_decreasing_pass_loop(Index, Counts, AccResult, Added) when Index >= 0 ->
    Count = array:get(Index, Counts),
    if
        Count > 0 ->
            Char = $a + Index,
            NewCounts = array:set(Index, Count - 1, Counts),
            do_decreasing_pass_loop(Index - 1, NewCounts, [Char | AccResult], Added + 1);
        true ->
            do_decreasing_pass_loop(Index - 1, Counts, AccResult, Added)
    end;
do_decreasing_pass_loop(-1, Counts, AccResult, Added) ->
    {Counts, AccResult, Added}.