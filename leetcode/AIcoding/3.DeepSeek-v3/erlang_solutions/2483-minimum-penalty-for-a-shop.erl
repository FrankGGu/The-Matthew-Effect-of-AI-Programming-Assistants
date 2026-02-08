-spec best_closing_time(Customers :: unicode:unicode_binary()) -> integer().
best_closing_time(Customers) ->
    S = binary_to_list(Customers),
    Len = length(S),
    PrefixN = lists:foldl(fun(Char, Acc) -> 
                            case Char of
                                $N -> [hd(Acc) + 1 | tl(Acc)];
                                _ -> Acc
                            end
                          end, [0], S),
    PrefixNList = lists:reverse([0 | PrefixN]),

    SuffixY = lists:foldr(fun(Char, Acc) -> 
                            case Char of
                                $Y -> [hd(Acc) + 1 | tl(Acc)];
                                _ -> Acc
                            end
                          end, [0], S),
    SuffixYList = SuffixY ++ [0],

    lists:foldl(fun(I, {MinPenalty, BestTime}) ->
                    Penalty = lists:nth(I + 1, PrefixNList) + lists:nth(I + 1, SuffixYList),
                    if 
                        Penalty < MinPenalty -> {Penalty, I};
                        true -> {MinPenalty, BestTime}
                    end
                end, {length(S) + 1, -1}, lists:seq(0, Len)) of {_, BestTime} -> BestTime end.