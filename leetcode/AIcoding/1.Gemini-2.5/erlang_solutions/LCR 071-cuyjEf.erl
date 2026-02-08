-module(solution).
-export([new/1, pickIndex/1]).

-record(solution_state, {prefix_sums :: [integer()], total_sum :: integer()}).

new(W) ->
    PrefixSums = calculate_prefix_sums(W, 0, []),
    TotalSum = case PrefixSums of
                   [] -> 0;
                   _ -> lists:last(PrefixSums)
               end,
    #solution_state{prefix_sums = PrefixSums, total_sum = TotalSum}.

calculate_prefix_sums([], _, Acc) ->
    lists:reverse(Acc).
calculate_prefix_sums([H|T], CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    calculate_prefix_sums(T, NewSum, [NewSum|Acc]).

pickIndex(SolutionState) ->
    #solution_state{prefix_sums = PrefixSums, total_sum = TotalSum} = SolutionState,
    RandomNum = random:uniform(TotalSum),
    find_index(RandomNum, PrefixSums, 0).

find_index(RandomNum, [H|_T], Index) when RandomNum =< H ->
    Index;
find_index(RandomNum, [_H|T], Index) ->
    find_index(RandomNum, T, Index + 1).