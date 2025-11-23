-module(nice_pairs).
-export([count_nice_pairs/1]).

reverse(N) ->
    reverse(N, 0).

reverse(0, Acc) ->
    Acc;
reverse(N, Acc) ->
    reverse(N div 10, Acc * 10 + N rem 10).

count_nice_pairs(Nums) ->
    count_nice_pairs(Nums, 0, []).

count_nice_pairs([], Count, _) ->
    Count;
count_nice_pairs([H|T], Count, Seen) ->
    Diff = H - reverse(H),
    case lists:member(Diff, Seen) of
        true ->
            NewCount = Count + lists:foldl(fun(X, Acc) -> if X == Diff then Acc + 1 else Acc end, 0, Seen),
            count_nice_pairs(T, NewCount, [Diff|Seen]);
        false ->
            count_nice_pairs(T, Count, [Diff|Seen])
    end.