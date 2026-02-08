-module(solution).
-export([minimumOperations/1]).

minimumOperations(Nums) ->
    N = length(Nums),
    if N =< 1 -> 0;
       true ->
            {EvenFreq, OddFreq} = count_frequencies(Nums, 0, #{}, #{}),

            N_even = (N + 1) div 2,
            N_odd = N div 2,

            {{Count1E, Val1E}, {Count2E, _Val2E}} = get_top_two_freq(EvenFreq),
            {{Count1O, Val1O}, {Count2O, _Val2O}} = get_top_two_freq(OddFreq),

            if Val1E =:= Val1O ->
                   OpsA = (N_even - Count1E) + (N_odd - Count2O),
                   OpsB = (N_even - Count2E) + (N_odd - Count1O),
                   min(OpsA, OpsB);
               true ->
                   (N_even - Count1E) + (N_odd - Count1O)
            end
    end.

count_frequencies(Nums, Index, EvenAcc, OddAcc) ->
    case Nums of
        [] -> {EvenAcc, OddAcc};
        [H|T] ->
            if Index rem 2 =:= 0 ->
                   NewEvenAcc = maps:update_with(H, fun(V) -> V + 1 end, 1, EvenAcc),
                   count_frequencies(T, Index + 1, NewEvenAcc, OddAcc);
               true ->
                   NewOddAcc = maps:update_with(H, fun(V) -> V + 1 end, 1, OddAcc),
                   count_frequencies(T, Index + 1, EvenAcc, NewOddAcc)
            end
    end.

get_top_two_freq(Map) ->
    CountsKeys = lists:map(fun({K, V}) -> {V, K} end, maps:to_list(Map)),
    SortedCountsKeys = lists:sort(fun({C1, _}, {C2, _}) -> C1 >= C2 end, CountsKeys),

    case SortedCountsKeys of
        [{C1, K1}, {C2, K2} | _] -> {{C1, K1}, {C2, K2}};
        [{C1, K1}] -> {{C1, K1}, {0, -2}};
        [] -> {{0, -1}, {0, -2}}
    end.