-spec longest_palindrome(Words :: [binary()]) -> integer().
longest_palindrome(Words) ->
    Counts = lists:foldl(fun(Word, Acc) ->
                                 maps:update_with(Word, fun(Val) -> Val + 1 end, 1, Acc)
                         end, maps:new(), Words),

    {FinalLength, FinalHasCentralOddPalindrome, _} =
        maps:fold(fun(Word, _InitialCount, Acc) ->
                          process_word(Word, Acc)
                  end, {0, false, Counts}, Counts),

    case FinalHasCentralOddPalindrome of
        true -> FinalLength + 2;
        false -> FinalLength
    end.

process_word(Word, {CurrentLength, CurrentHasCentralOddPalindrome, CurrentCountsMap}) ->
    case maps:get(Word, CurrentCountsMap, 0) of
        0 ->
            {CurrentLength, CurrentHasCentralOddPalindrome, CurrentCountsMap};
        ActualCount ->
            RevWord = list_to_binary(lists:reverse(binary_to_list(Word))),

            if Word == RevWord ->
                   Pairs = ActualCount div 2,
                   NewLength = CurrentLength + Pairs * 4,
                   NewHasCentralOddPalindrome = CurrentHasCentralOddPalindrome orelse (ActualCount rem 2 == 1),
                   UpdatedCountsMap = maps:put(Word, 0, CurrentCountsMap),
                   {NewLength, NewHasCentralOddPalindrome, UpdatedCountsMap};
               true ->
                   case maps:get(RevWord, CurrentCountsMap, 0) of
                       0 ->
                           {CurrentLength, CurrentHasCentralOddPalindrome, CurrentCountsMap};
                       RevCount ->
                           Pairs = min(ActualCount, RevCount),
                           NewLength = CurrentLength + Pairs * 4,
                           UpdatedCountsMap1 = maps:put(Word, 0, CurrentCountsMap),
                           UpdatedCountsMap2 = maps:put(RevWord, 0, UpdatedCountsMap1),
                           {NewLength, CurrentHasCentralOddPalindrome, UpdatedCountsMap2}
                   end
            end
    end.