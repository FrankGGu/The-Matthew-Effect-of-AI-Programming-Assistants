-module(solution).
-export([count_pairs/1]).

count_pairs(Pairs) ->
    Count = maps:from_list([{T, 0} || T <- lists:seq(0, 23)]),
    count_pairs(Pairs, Count).

count_pairs([], _Count) ->
    0;

count_pairs([{H1, H2} | Rest], Count) ->
    Hour1 = H1,
    Hour2 = H2,
    Total = (Hour1 + Hour2) rem 24,
    case maps:get(Total, Count, 0) of
        0 ->
            count_pairs(Rest, maps:update(Hour1, maps:get(Hour1, Count, 0) + 1, Count));
        N ->
            count_pairs(Rest, maps:update(Hour1, maps:get(Hour1, Count, 0) + 1, maps:update(Total, N - 1, Count)))
    end.