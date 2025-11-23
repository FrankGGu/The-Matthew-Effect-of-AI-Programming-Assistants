-module(next_permutation).
-export([next_permutation/1]).

next_permutation(List) ->
    case find_pivot_and_split(List) of
        not_found ->
            lists:reverse(List);
        {Prefix, Pivot, SuffixDesc} ->
            % Prefix: [nums[0], ..., nums[k-1]]
            % Pivot: nums[k]
            % SuffixDesc: [nums[k+1], ..., nums[n-1]] (in descending order)

            % Find nums[l] (the smallest element in SuffixDesc that is greater than Pivot)
            {RemainingSuffix, SwapElement} = find_swap_element(SuffixDesc, Pivot),

            % Construct the result:
            % 1. Prefix
            % 2. SwapElement
            % 3. The remaining part ([Pivot | RemainingSuffix]) reversed to sort it ascendingly
            Prefix ++ [SwapElement] ++ lists:reverse([Pivot | RemainingSuffix])
    end.

find_pivot_and_split(List) ->
    % State: {PivotFound, PivotValue, SuffixDesc, PrefixReversed}
    % SuffixDesc is built from right to left, so it's naturally descending.
    % PrefixReversed is built from right to left, accumulating elements before the pivot.
    Result = lists:foldr(
        fun(Element, {false, CurrentSuffixDesc, CurrentPrefixReversed}) -> % Element is current element from right
            case CurrentSuffixDesc of
                [] -> % Element is the rightmost element.
                    {false, [Element], []};
                [HeadSuffix | _] ->
                    if Element < HeadSuffix -> % Found pivot! Element is nums[k], HeadSuffix is nums[k+1]
                        {true, Element, CurrentSuffixDesc, CurrentPrefixReversed};
                    true -> % Not a pivot, continue building CurrentSuffixDesc
                        {false, [Element | CurrentSuffixDesc], CurrentPrefixReversed}
                    end
            end;
        fun(Element, {true, Pivot, SuffixDesc, CurrentPrefixReversed}) -> % Pivot already found, just build prefix
            {true, Pivot, SuffixDesc, [Element | CurrentPrefixReversed]}
        end,
        {false, [], []}, % Initial state: {PivotFound, PivotValue, SuffixDesc, PrefixReversed}
        List
    ).

    case Result of
        {true, Pivot, SuffixDesc, PrefixReversed} ->
            {lists:reverse(PrefixReversed), Pivot, SuffixDesc};
        {false, _, _} -> % No pivot found, list is in descending order
            not_found
    end.

find_swap_element([H | T], Pivot) when H > Pivot ->
    % H is the smallest element in SuffixDesc that is greater than Pivot
    {T, H};
find_swap_element([H | T], Pivot) ->
    % Keep searching
    {RemainingSuffix, SwapElement} = find_swap_element(T, Pivot),
    {[H | RemainingSuffix], SwapElement}.