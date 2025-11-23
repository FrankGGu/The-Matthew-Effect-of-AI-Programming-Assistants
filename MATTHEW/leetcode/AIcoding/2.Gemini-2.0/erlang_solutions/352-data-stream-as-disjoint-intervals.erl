-module(summary_ranges).
-export([new/0, addNum/2, getIntervals/1]).

new() ->
    ordsets:new().

addNum(Set, Val) ->
    ordsets:add_element(Val, Set).

getIntervals(Set) ->
    getIntervals_helper(ordsets:to_list(Set), []).

getIntervals_helper([], Acc) ->
    lists:reverse(Acc);
getIntervals_helper([H], Acc) ->
    lists:reverse([{H, H} | Acc]);
getIntervals_helper([H1, H2 | T], Acc) ->
    if
        H2 == H1 + 1 ->
            getIntervals_extended([H2 | T], H1, H2, Acc);
        true ->
            getIntervals_helper([H2 | T], [{H1, H1} | Acc])
    end.

getIntervals_extended([H2 | T], Start, Last, Acc) ->
    case T of
        [] ->
            lists:reverse([{Start, H2} | Acc]);
        [Next | Rest] ->
            if
                Next == H2 + 1 ->
                    getIntervals_extended([Next | Rest], Start, Next, Acc);
                true ->
                    getIntervals_helper([Next | Rest], [{Start, H2} | Acc])
            end
    end.