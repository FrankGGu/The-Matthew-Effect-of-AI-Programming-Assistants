-spec smallest_palindrome(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
smallest_palindrome(S) ->
    List = unicode:characters_to_list(S),
    Freq = count_freq(List),
    case can_form_palindrome(Freq) of
        false -> <<>>;
        true -> 
            {Half, Middle} = build_half_and_middle(Freq),
            PalindromeList = Half ++ Middle ++ lists:reverse(Half),
            unicode:characters_to_binary(PalindromeList)
    end.

count_freq(List) ->
    count_freq(List, #{}).
count_freq([], Freq) -> Freq;
count_freq([Char | Rest], Freq) ->
    NewFreq = maps:update_with(Char, fun(V) -> V + 1 end, 1, Freq),
    count_freq(Rest, NewFreq).

can_form_palindrome(Freq) ->
    OddCount = maps:fold(fun(_, V, Acc) -> 
        case V rem 2 of
            1 -> Acc + 1;
            0 -> Acc
        end
    end, 0, Freq),
    OddCount =< 1.

build_half_and_middle(Freq) ->
    SortedChars = lists:sort(maps:keys(Freq)),
    {Half, Middle} = build_half_and_middle(SortedChars, Freq, [], []),
    {lists:flatten(Half), Middle}.

build_half_and_middle([], _, HalfAcc, MiddleAcc) -> {HalfAcc, MiddleAcc};
build_half_and_middle([Char | Rest], Freq, HalfAcc, MiddleAcc) ->
    Count = maps:get(Char, Freq),
    case Count rem 2 of
        1 -> 
            NewHalfAcc = HalfAcc ++ lists:duplicate(Count div 2, Char),
            build_half_and_middle(Rest, Freq, NewHalfAcc, [Char]);
        0 -> 
            NewHalfAcc = HalfAcc ++ lists:duplicate(Count div 2, Char),
            build_half_and_middle(Rest, Freq, NewHalfAcc, MiddleAcc)
    end.