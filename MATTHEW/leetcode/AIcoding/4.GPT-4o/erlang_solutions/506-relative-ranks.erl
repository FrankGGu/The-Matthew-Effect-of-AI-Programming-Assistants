-module(solution).
-export([find_relative_ranks/1]).

-spec find_relative_ranks([integer()]) -> [unicode:unicode_binary()].
find_relative_ranks(Score) ->
    SortedScores = lists:sort(fun(X, Y) -> X > Y end, Score),
    ranks(SortedScores, Score, [], 1).

ranks(_, [], Acc, _) -> lists:reverse(Acc);
ranks(SortedScores, [Head | Tail], Acc, Rank) ->
    case lists:member(Head, SortedScores) of
        true -> 
            RankStr = case Rank of
                        1 -> "Gold Medal";
                        2 -> "Silver Medal";
                        3 -> "Bronze Medal";
                        _ -> integer_to_list(Rank)
                      end,
            ranks(SortedScores, Tail, [RankStr | Acc], Rank + 1);
        false -> ranks(SortedScores, Tail, Acc, Rank)
    end.
