-module(solution).
-export([subseq_gcd_by_diff/1]).

subseq_gcd_by_diff(Nums) ->
    Max = lists:max(Nums),
    Seen = sets:new(),
    Count = 0,
    subseq_gcd_by_diff(Nums, Max, Seen, Count).

subseq_gcd_by_diff([], _, _, Count) ->
    Count;
subseq_gcd_by_diff([N | Rest], Max, Seen, Count) ->
    NewCount = count_gcds(N, Max, Seen),
    subseq_gcd_by_diff(Rest, Max, sets:union(Seen, sets:from_list([N])), Count + NewCount).

count_gcds(N, Max, Seen) ->
    count_gcds(N, 1, Max, Seen, 0).

count_gcds(_, G, Max, _, Count) when G > Max ->
    Count;
count_gcds(N, G, Max, Seen, Count) ->
    case math:gcd(N, G) of
        G ->
            case sets:is_element(G, Seen) of
                true -> count_gcds(N, G + 1, Max, Seen, Count);
                false -> count_gcds(N, G + 1, Max, Seen, Count + 1)
            end;
        _ ->
            count_gcds(N, G + 1, Max, Seen, Count)
    end.