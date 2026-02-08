-module(solution).
-export([can_eat_favorite_candy/2]).

can_eat_favorite_candy(CandiesCountList, Queries) ->
    CandiesCountArray = array:from_list(CandiesCountList),
    N = array:size(CandiesCountArray),

    PrefixSumsArray = generate_prefix_sums_array(CandiesCountArray, N),

    lists:map(fun([CandyType, Day, DailyCap]) ->
                      check_query(CandyType, Day, DailyCap, CandiesCountArray, PrefixSumsArray)
              end, Queries).

generate_prefix_sums_array(CandiesCountArray, N) ->
    array:from_list(generate_prefix_sums_list(CandiesCountArray, N, 0, [0])).

generate_prefix_sums_list(CandiesCountArray, N, Index, Acc) when Index < N ->
    CurrentCandyCount = array:get(Index, CandiesCountArray),
    CurrentSum = hd(Acc),
    generate_prefix_sums_list(CandiesCountArray, N, Index + 1, [CurrentSum + CurrentCandyCount | Acc]);
generate_prefix_sums_list(_CandiesCountArray, _N, _Index, Acc) ->
    lists:reverse(Acc).

check_query(CandyType, Day, DailyCap, CandiesCountArray, PrefixSumsArray) ->
    PrefixSum_CandyType = array:get(CandyType, PrefixSumsArray),
    CandyCount_CandyType = array:get(CandyType, CandiesCountArray),

    MinTotalCandies_by_Day = Day + 1,
    MaxTotalCandies_by_Day = (Day + 1) * DailyCap,

    IdxStart_CandyType = PrefixSum_CandyType,
    IdxEnd_CandyType = PrefixSum_CandyType + CandyCount_CandyType - 1,

    max(MinTotalCandies_by_Day, IdxStart_CandyType) =< min(MaxTotalCandies_by_Day, IdxEnd_CandyType).