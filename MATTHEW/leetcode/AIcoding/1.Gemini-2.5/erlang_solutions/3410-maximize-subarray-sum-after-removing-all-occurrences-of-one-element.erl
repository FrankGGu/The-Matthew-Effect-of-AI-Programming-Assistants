-module(solution).
-export([maximum_subarray_sum_after_removing_one_element/1]).

kadane(List) ->
    {MaxSum, _CurrentSum, HasElements, MaxElement} =
        lists:foldl(
            fun(X, {AccMaxSum, AccCurrentSum, AccHasElements, AccMaxElement}) ->
                NewHasElements = true,
                NewCurrentSum = AccCurrentSum + X,
                NewMaxElement = max(AccMaxElement, X),
                UpdatedCurrentSum = max(0, NewCurrentSum),
                NewMaxSum = max(AccMaxSum, UpdatedCurrentSum),
                {NewMaxSum, UpdatedCurrentSum, NewHasElements, NewMaxElement}
            end,
            {0, 0, false, -1000000001},
            List
        ),

    if
        not HasElements -> 0;
        MaxSum == 0 andalso MaxElement < 0 -> MaxElement;
        true -> MaxSum
    end.

maximum_subarray_sum_after_removing_one_element(Nums) ->
    UniqueElements = lists:usort(Nums),

    OverallMaxSum = 0,

    lists:foldl(
        fun(ElementToRemove, AccOverallMaxSum) ->
            FilteredList = [X || X <- Nums, X =/= ElementToRemove],

            CurrentMax = kadane(FilteredList),

            max(AccOverallMaxSum, CurrentMax)
        end,
        OverallMaxSum,
        UniqueElements
    ).