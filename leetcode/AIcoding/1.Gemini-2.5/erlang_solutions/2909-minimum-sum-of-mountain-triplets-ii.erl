-module(solution).
-export([minimum_sum_of_mountain_triplets/1]).

-define(INF, 3000000001).

minimum_sum_of_mountain_triplets(Nums) ->
    N = length(Nums),
    if
        N < 3 -> -1;
        true ->
            MinLeft = generate_min_left_prefix(Nums),
            MinRight = generate_min_right_suffix(Nums),

            Zipped = lists:zip3(Nums, MinLeft, MinRight),

            MiddleTriplets = lists:sublist(Zipped, 2, N-2),

            MinSum = find_min_sum(MiddleTriplets, ?INF),

            case MinSum of
                ?INF -> -1;
                _ -> MinSum
            end
    end.

generate_min_left_prefix(Nums) ->
    generate_min_left_prefix(Nums, [], ?INF).

generate_min_left_prefix([], Acc, _CurrentMin) ->
    lists:reverse(Acc);
generate_min_left_prefix([H|T], Acc, CurrentMin) ->
    generate_min_left_prefix(T, [CurrentMin|Acc], min(CurrentMin, H)).

generate_min_right_suffix(Nums) ->
    generate_min_right_suffix(lists:reverse(Nums), [], ?INF).

generate_min_right_suffix([], Acc, _CurrentMin) ->
    Acc;
generate_min_right_suffix([H|T], Acc, CurrentMin) ->
    generate_min_right_suffix(T, [CurrentMin|Acc], min(CurrentMin, H)).

find_min_sum([], CurrentMinSum) ->
    CurrentMinSum;
find_min_sum([{NumJ, MinLeftJ, MinRightJ}|T], CurrentMinSum) ->
    if
        MinLeftJ < NumJ andalso MinRightJ < NumJ ->
            NewSum = MinLeftJ + NumJ + MinRightJ,
            find_min_sum(T, min(CurrentMinSum, NewSum));
        true ->
            find_min_sum(T, CurrentMinSum)
    end.