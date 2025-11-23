-module(solution).
-export([solve/1]).

solve(S) ->
    Counts = count_chars(S),
    {CanForm, OddChar} = check_palindrome_and_middle(Counts),
    case CanForm of
        false ->
            [];
        true ->
            FirstHalfParts = build_first_half_parts(Counts),
            FirstHalf = lists:append(FirstHalfParts),
            MiddlePart = case OddChar of
                             none -> [];
                             Char -> [Char]
                         end,
            lists:append([FirstHalf, MiddlePart, lists:reverse(FirstHalf)])
    end.

count_chars(S) ->
    InitialCounts = lists:duplicate(26, 0),
    lists:foldl(fun(Char, Acc) ->
                        Index = Char - $a,
                        lists:replace_at(Index + 1, lists:nth(Index + 1, Acc) + 1, Acc)
                end, InitialCounts, S).

check_palindrome_and_middle(Counts) ->
    {FinalOddCount, FinalOddChar, _} = lists:foldl(
        fun(Count, {AccOddCount, AccOddChar, CurrentIndex}) ->
            if
                Count rem 2 =:= 1 ->
                    NewOddCount = AccOddCount + 1,
                    NewOddChar = case AccOddChar of
                                     none -> $a + CurrentIndex;
                                     _ -> AccOddChar
                                 end,
                    {NewOddCount, NewOddChar, CurrentIndex + 1};
                true ->
                    {AccOddCount, AccOddChar, CurrentIndex + 1}
            end
        end, {0, none, 0}, Counts),
    if
        FinalOddCount > 1 ->
            {false, none};
        true ->
            {true, FinalOddChar}
    end.

build_first_half_parts(Counts) ->
    {FirstHalfParts, _} = lists:foldl(
        fun(Count, {AccFirstHalfParts, CurrentIndex}) ->
            Char = $a + CurrentIndex,
            NumToAdd = Count div 2,
            Part = lists:duplicate(NumToAdd, Char),
            {[Part | AccFirstHalfParts], CurrentIndex + 1}
        end, {[], 0}, Counts),
    lists:reverse(FirstHalfParts).