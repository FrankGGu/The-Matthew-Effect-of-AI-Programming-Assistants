-module(solution).
-export([countPairs/3]).

countPairs(Nums1, Nums2, K) ->
    % Step 1: Group nums2 values with their original indices by nums1 values.
    % The map will be: #{Num1Value => [{Num2Value, Index}, ...]}.
    % The lists are built in reverse index order due to prepending,
    % e.g., for indices [0, 1, 2], the list will be [{Val2,2}, {Val1,1}, {Val0,0}].
    GroupedMap = build_grouped_map(Nums1, Nums2),

    % Step 2, 3, 4: Iterate through groups and count pairs.
    maps:fold(fun(_Num1Value, Num2ValuesWithIndicesList, AccTotalCount) ->
                  % Process each group's list in increasing order of index.
                  % Reverse the list to get original index order.
                  SortedList = lists:reverse(Num2ValuesWithIndicesList),
                  count_pairs_in_group(SortedList, K, AccTotalCount)
              end, 0, GroupedMap).

build_grouped_map(Nums1, Nums2) ->
    build_grouped_map(Nums1, Nums2, 0, maps:new()).

build_grouped_map([], [], _Idx, AccMap) ->
    AccMap;
build_grouped_map([H1|T1], [H2|T2], Idx, AccMap) ->
    % Prepend {Num2Value, Index} to the list for the current Num1Value.
    % maps:update_with ensures the key exists or creates it with the initial list.
    AccMap1 = maps:update_with(H1, fun(List) -> [{H2, Idx} | List] end, [{H2, Idx}], AccMap),
    build_grouped_map(T1, T2, Idx + 1, AccMap1).

count_pairs_in_group(Num2ValuesWithIndicesList, K, CurrentTotalCount) ->
    % AccGroupPairs is a tuple {FreqMap, GroupSpecificCount}.
    % FreqMap: #{Num2Value => Count} of values encountered at smaller indices.
    % GroupSpecificCount: Pairs found within this group.
    {_FinalFreqMap, FinalGroupPairs} = lists:foldl(
        fun({Val, _Idx}, {CurrentFreqMap, AccGroupPairs}) ->
            PairsToAdd = if K == 0 ->
                             % For K=0, we need nums2[i] == nums2[j].
                             % Count how many times 'Val' has appeared before this current 'Val'.
                             maps:get(Val, CurrentFreqMap, 0);
                        true -> % K > 0
                             % For K > 0, we need abs(nums2[i] - nums2[j]) == K.
                             % This means nums2[j] = nums2[i] + K or nums2[j] = nums2[i] - K.
                             % When processing 'Val' at index 'j', we look for 'Val - K' and 'Val + K'
                             % in the FreqMap (which contains values from indices < j).
                             CountMinusK = maps:get(Val - K, CurrentFreqMap, 0),
                             CountPlusK = maps:get(Val + K, CurrentFreqMap, 0),
                             CountMinusK + CountPlusK
                         end,

            % Update FreqMap with the current 'Val' for future iterations.
            NewFreqMap = maps:update_with(Val, fun(Count) -> Count + 1 end, 1, CurrentFreqMap),

            {NewFreqMap, AccGroupPairs + PairsToAdd}
        end,
        {maps:new(), 0}, % Initial accumulator: empty FreqMap and 0 pairs.
        Num2ValuesWithIndicesList
    ),

    CurrentTotalCount + FinalGroupPairs.