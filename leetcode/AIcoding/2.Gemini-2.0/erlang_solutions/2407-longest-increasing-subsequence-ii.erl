-module(longest_increasing_subsequence_ii).
-export([lengthOfLIS/1]).

lengthOfLIS(Nums) ->
    lengthOfLIS(Nums, []).

lengthOfLIS([], Tails) ->
    length(Tails);
lengthOfLIS([Num | Rest], Tails) ->
    NewTails = updateTails(Num, Tails),
    lengthOfLIS(Rest, NewTails).

updateTails(Num, []) ->
    [Num];
updateTails(Num, [Head | Rest]) ->
    case Num > Head of
        true ->
            [Head | updateTails(Num, Rest)];
        false ->
            case Rest of
                [] ->
                    [Num];
                _ ->
                    case Num < Head of
                        true ->
                            [Num | Rest];
                        false ->
                            [Head | Rest]
                    end
            end
    end.