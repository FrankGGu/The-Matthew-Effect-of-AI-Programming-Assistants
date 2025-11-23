-module(solution).
-export([count_pairs/2]).

count_pairs(Nums, Target) ->
    count_pairs(Nums, Target, 0, 0).

count_pairs([], _, _, Count) ->
    Count;
count_pairs([H | T], Target, Index, Count) ->
    NewCount = count_less_than(H, T, Target, 0),
    count_pairs(T, Target, Index + 1, Count + NewCount).

count_less_than(_, [], _, Count) ->
    Count;
count_less_than(Num, [H | T], Target, Count) ->
    if Num + H < Target -> count_less_than(Num, T, Target, Count + 1);
       true -> count_less_than(Num, T, Target, Count)
    end.