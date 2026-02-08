-module(solution).
-export([maximumTotalBeauty/5]).

maximumTotalBeauty(Flowers, NewFlowers, Target, FullBeauty, PartialBeauty) ->
    FlowersSorted = lists:sort(Flowers),
    N = length(FlowersSorted),

    FlowersArray = array:from_list(FlowersSorted),

    % PrefixSumsArray[i] = sum(FlowersSorted[0...i-1])
    % PrefixSumsArray[0] = 0
    PrefixSumsArray = array:new([{size, N + 1}, {default, 0}]),
    {_, FinalPrefixSumsArray} = lists:foldl(fun(F, {Idx, AccArray}) ->
        CurrentSum = array:get(Idx, AccArray),
        NewSum = CurrentSum + F,
        NewAccArray = array:set(Idx + 1, NewSum, AccArray),
        {Idx + 1, NewAccArray}
    end, {0, PrefixSumsArray}, FlowersSorted),

    calculate_max_beauty(N, FlowersArray, FinalPrefixSumsArray, NewFlowers, Target, FullBeauty, PartialBeauty).

calculate_max_beauty(N, FlowersArray, PrefixSumsArray, NewFlowers, Target, FullBeauty, PartialBeauty) ->
    MaxBeauty = 0,
    % Iterate `K` from 0 to N. `K` is the number of gardens that are *partial* (or left as is).
    % These are FlowersArray[0...K-1].
    % The remaining N-K gardens (FlowersArray[K...N-1]) are made full.
    lists:foldl(fun(K, CurrentMaxBeauty) ->
        % 1. Calculate cost for full gardens (FlowersArray[K...N-1])
        FullCost = calculate_full_cost(FlowersArray, K, N, Target, PrefixSumsArray),

        if FullCost > NewFlowers ->
            % Cannot afford to make these N-K gardens full.
            % Since K is increasing, N-K is decreasing, so FullCost will decrease.
            % We can continue to the next K.
            CurrentMaxBeauty;
        else
            RemainingBudget = NewFlowers - FullCost,

            % 2. Calculate max partial beauty for FlowersArray[0...K-1]
            MinPartialBeauty = find_max_min_partial_beauty(FlowersArray, K, RemainingBudget, Target - 1, PrefixSumsArray),

            % 3. Calculate total beauty
            CurrentBeauty = (N - K) * FullBeauty + MinPartialBeauty * PartialBeauty,
            max(CurrentBeauty, CurrentMaxBeauty)
        end
    end, MaxBeauty, lists:seq(0, N)).

calculate_full_cost(FlowersArray, StartIdx, EndIdx, Target, PrefixSumsArray) ->
    if StartIdx >= EndIdx -> 0; % No gardens to make full
       true ->
            % Find the first garden in FlowersArray[StartIdx...EndIdx-1] that is >= Target
            FirstAboveTargetIdx = lower_bound_array_for_range(FlowersArray, Target, StartIdx, EndIdx - 1),

            % Gardens from StartIdx to FirstAboveTargetIdx-1 need to be filled up to Target
            NumToFill = FirstAboveTargetIdx - StartIdx,

            % Sum of beauties for these gardens: PrefixSumsArray[FirstAboveTargetIdx] - PrefixSumsArray[StartIdx]
            SumBeauties = array:get(FirstAboveTargetIdx, PrefixSumsArray) - array:get(StartIdx, PrefixSumsArray),

            Cost = NumToFill * Target - SumBeauties,
            Cost
    end.

find_max_min_partial_beauty(FlowersArray, K_partial, Budget, MaxBeautyCap, PrefixSumsArray) ->
    if K_partial == 0 -> 0;
       true ->
            Low = 0,
            High = MaxBeautyCap,
            binary_search_max_min_partial(FlowersArray, K_partial, Budget, Low, High, 0, PrefixSumsArray)
    end.

binary_search_max_min_partial(FlowersArray, K_partial, Budget, Low, High, CurrentMaxX, PrefixSumsArray) ->
    if Low > High -> CurrentMaxX;
       true ->
            Mid = Low + (High - Low) div 2,
            Cost = calculate_partial_cost_optimized(FlowersArray, K_partial, Mid, PrefixSumsArray),
            if Cost =< Budget ->
                binary_search_max_min_partial(FlowersArray, K_partial, Budget, Mid + 1, High, Mid, PrefixSumsArray);
            else
                binary_search_max_min_partial(FlowersArray, K_partial, Budget, Low, Mid - 1, CurrentMaxX, PrefixSumsArray)
            end
    end.

calculate_partial_cost_optimized(FlowersArray, K_partial, MinBeauty, PrefixSumsArray) ->
    % Find the count of elements in FlowersArray[0...K_partial-1] that are strictly less than MinBeauty.
    % This is the index of the first element >= MinBeauty in that range.
    Idx = lower_bound_array_for_range(FlowersArray, MinBeauty, 0, K_partial - 1),

    % Sum of beauties for FlowersArray[0...Idx-1]
    SumOfSmallElements = array:get(Idx, PrefixSumsArray),

    Cost = Idx * MinBeauty - SumOfSmallElements,
    Cost.

lower_bound_array_for_range(Array, Value, StartIdx, EndIdx) ->
    lower_bound_array_for_range_impl(Array, Value, StartIdx, EndIdx, EndIdx + 1).

lower_bound_array_for_range_impl(Array, Value, Low, High, Ans) ->
    if Low > High -> Ans;
       true ->
            MidIdx = Low + (High - Low) div 2,
            MidVal = array:get(MidIdx, Array),
            if MidVal >= Value ->
                lower_bound_array_for_range_impl(Array, Value, Low, MidIdx - 1, MidIdx); % Possible answer, try left
            else
                lower_bound_array_for_range_impl(Array, Value, MidIdx + 1, High, Ans) % Too small, try right
            end
    end.

max(A, B) when A >= B -> A;
max(A, B) -> B.