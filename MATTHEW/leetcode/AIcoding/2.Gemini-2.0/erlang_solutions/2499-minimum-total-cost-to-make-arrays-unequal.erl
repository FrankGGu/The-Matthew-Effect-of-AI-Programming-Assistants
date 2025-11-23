-module(minimum_total_cost).
-export([minimum_total_cost/2]).

minimum_total_cost(Nums1, Nums2) ->
    Len = length(Nums1),
    {Common, Count} = find_most_common(Nums1, Nums2),

    if Count * 2 <= Len then
        TotalCost = calculate_initial_cost(Nums1, Nums2),
        return TotalCost
    else
        Unmatched1 = [],
        Unmatched2 = [],
        TotalCost = calculate_initial_cost(Nums1, Nums2),

        lists:foreach(
            fun(I) ->
                if Nums1[I+1] =/= Nums2[I+1] andalso Nums1[I+1] =:= Common then
                    Unmatched1 ++= [I]
                end,
                if Nums1[I+1] =/= Nums2[I+1] andalso Nums2[I+1] =:= Common then
                    Unmatched2 ++= [I]
                end
            end,
            lists:seq(0, Len - 1)
        ),

        Need = Count * 2 - Len,
        if length(Unmatched1) + length(Unmatched2) >= Need then
            lists:sort(fun(A,B) -> A < B end,Unmatched1),
            lists:sort(fun(A,B) -> A < B end,Unmatched2),

            UnmatchedIndices = lists:seq(0, Len - 1) -- (Unmatched1 ++ Unmatched2),

            CostUnmatched = 0,

            for(I, 1, Need, 1) do
              if length(Unmatched1) > 0 then
                Unmatched1New = tl(Unmatched1),
                CostUnmatched1 = hd(Unmatched1);
                Unmatched1 = Unmatched1New,
                CostUnmatched = CostUnmatched + CostUnmatched1 + 1
               else if length(Unmatched2) > 0 then
                Unmatched2New = tl(Unmatched2),
                CostUnmatched2 = hd(Unmatched2);
                Unmatched2 = Unmatched2New,
                CostUnmatched = CostUnmatched + CostUnmatched2 + 1
                else
                  true
              end
              end
            end,

            return TotalCost + CostUnmatched
        else
            return -1
        end
    end.

calculate_initial_cost(Nums1, Nums2) ->
    Len = length(Nums1),
    lists:sum(
        lists:map(
            fun(I) ->
                if Nums1[I+1] =:= Nums2[I+1] then
                    I + 1
                else
                    0
                end
            end,
            lists:seq(0, Len - 1)
        )
    ).

find_most_common(Nums1, Nums2) ->
    Len = length(Nums1),
    Matches = lists:filter(
        fun(I) -> Nums1[I+1] =:= Nums2[I+1] end,
        lists:seq(0, Len - 1)
    ),

    if length(Matches) == 0 then
      {0,0}
    else
      Values = [Nums1[I+1] || I <- Matches],
      {MostCommon, Count} = find_most_frequent(Values),
      {MostCommon, Count}
    end.

find_most_frequent(List) ->
    Counts = lists:foldl(
        fun(X, Acc) ->
            case lists:keyfind(X, 1, Acc) of
                false -> [{X, 1} | Acc];
                {X, C} -> lists:keyreplace(X, 1, Acc, {X, C + 1})
            end
        end,
        [],
        List
    ),
    lists:foldl(
        fun({X, C}, {MaxVal, MaxCount}) ->
            if C > MaxCount then
                {X, C}
            else
                {MaxVal, MaxCount}
            end
        end,
        {0, 0},
        Counts
    ).

for(I, Start, End, Step) ->
  if I > End then
    ok
  else
    I,
    for(I+Step, Start, End, Step)
  end.