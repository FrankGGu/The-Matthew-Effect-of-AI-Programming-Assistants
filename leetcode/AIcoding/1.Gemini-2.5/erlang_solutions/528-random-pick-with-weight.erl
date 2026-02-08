-module(solution).
-export([new/1, pickIndex/1]).

-record(solution_state, {
    prefix_sums_tuple :: tuple(),
    total_sum :: integer()
}).

new(W) ->
    rand:seed(erlang:monotonic_time(), erlang:unique_integer([monotonic])),
    {PrefixSumsList, TotalSum} = calculate_prefix_sums(W),
    #solution_state{prefix_sums_tuple = list_to_tuple(PrefixSumsList), total_sum = TotalSum}.

pickIndex(State) ->
    #solution_state{prefix_sums_tuple = PrefixSumsTuple, total_sum = TotalSum} = State,
    Target = rand:uniform(TotalSum),
    binary_search(PrefixSumsTuple, Target, 1, tuple_size(PrefixSumsTuple)).

calculate_prefix_sums(W) ->
    calculate_prefix_sums(W, [], 0, 0).

calculate_prefix_sums([], AccPrefixSums, _CurrentSum, TotalSum) ->
    {lists:reverse(AccPrefixSums), TotalSum}.
calculate_prefix_sums([H|T], AccPrefixSums, CurrentSum, _TotalSum) ->
    NewCurrentSum = CurrentSum + H,
    calculate_prefix_sums(T, [NewCurrentSum|AccPrefixSums], NewCurrentSum, NewCurrentSum).

binary_search(Tuple, Target, Low, High) ->
    binary_search_impl(Tuple, Target, Low, High, -1).

binary_search_impl(_Tuple, _Target, Low, High, Ans) when Low > High ->
    Ans - 1;
binary_search_impl(Tuple, Target, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2,
    MidVal = element(Mid, Tuple),
    if
        MidVal >= Target ->
            binary_search_impl(Tuple, Target, Low, Mid - 1, Mid);
        MidVal < Target ->
            binary_search_impl(Tuple, Target, Mid + 1, High, Ans)
    end.