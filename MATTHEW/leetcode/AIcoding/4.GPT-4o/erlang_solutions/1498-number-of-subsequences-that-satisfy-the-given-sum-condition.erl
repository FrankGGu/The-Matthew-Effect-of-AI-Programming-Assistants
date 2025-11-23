-module(solution).
-export([numSubseq/2]).

numSubseq(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    Mod = 1000000007,
    Prefix = lists:foldl(fun(_, Acc) -> (Acc * 2) rem Mod end, 1, lists:seq(1, N)),
    Counts = lists:foldl(fun(X, Acc) -> [X | Acc] end, [], SortedNums),
    Counts = lists:reverse(Counts),
    numSubseq_helper(SortedNums, Counts, Target, N, 0, Mod).

numSubseq_helper(SortedNums, Counts, Target, N, Count, Mod) ->
    case lists:foldl(fun(X, {L, R}) -> 
                      case (X + lists:last(SortedNums)) =< Target of
                          true -> {L + 1, R};
                          false -> {L, R - 1}
                      end 
                   end, {0, N - 1}, SortedNums) of
        {L, R} when L > R -> Count;
        {L, R} -> 
            NewCount = (Count + (lists:nth(L, Counts) * lists:nth(R, Counts)) rem Mod) rem Mod,
            numSubseq_helper(SortedNums, Counts, Target, N, NewCount, Mod)
    end.