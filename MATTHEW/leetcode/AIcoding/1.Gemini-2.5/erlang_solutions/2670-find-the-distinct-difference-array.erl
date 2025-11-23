-module(solution).
-export([find_distinct_difference_array/1]).

find_distinct_difference_array(Nums) ->
    % Step 1: Pre-calculate distinct counts for all suffixes
    % SuffixCountsFromRight will be [distinct(Nums[0...]), distinct(Nums[1...]), ..., distinct(Nums[N-1...]), distinct([])]
    % Example: Nums = [1,2,3,4] -> SuffixCountsFromRight = [4,3,2,1,0]
    SuffixCountsFromRight = 
        lists:foldr(fun(E, {AccSet, AccList}) ->
                        NewAccSet = gb_sets:add(E, AccSet),
                        NewAccList = [gb_sets:size(NewAccSet) | AccList],
                        {NewAccSet, NewAccList}
                    end, {gb_sets:new(), [0]}, Nums),
    {_FinalSet, SuffixCounts} = SuffixCountsFromRight,

    % ActualSuffixDistincts will be [distinct(suffix[0]), distinct(suffix[1]), ..., distinct(suffix[N-1])]
    % where suffix[i] is Nums[i+1...N-1].
    % This corresponds to dropping the first element from SuffixCounts.
    % Example: [4,3,2,1,0] -> [3,2,1,0]
    ActualSuffixDistincts = tl(SuffixCounts),

    % Step 2: Iterate through Nums, maintaining prefix distinct count and using pre-calculated suffix distinct count
    calculate_diffs(Nums, ActualSuffixDistincts, gb_sets:new()).

calculate_diffs([], _ActualSuffixDistincts, _PrefixSet) ->
    [];
calculate_diffs([H|T], [CurrentSuffixDistinct | RemainingSuffixDistincts], PrefixSet) ->
    NewPrefixSet = gb_sets:add(H, PrefixSet),
    PrefixDistinct = gb_sets:size(NewPrefixSet),

    Diff = abs(PrefixDistinct - CurrentSuffixDistinct),

    [Diff | calculate_diffs(T, RemainingSuffixDistincts, NewPrefixSet)].