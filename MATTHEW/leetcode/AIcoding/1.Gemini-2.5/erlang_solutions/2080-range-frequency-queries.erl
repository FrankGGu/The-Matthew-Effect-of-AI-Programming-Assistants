-module(range_freq_query).
-export([new/1, query/4]).

new(Arr) ->
    % Step 1: Build a temporary map where values are lists of indices in reverse order.
    % This avoids O(N^2) list appends during construction.
    TempMap = lists:foldl(
        fun({Val, Idx}, AccMap) ->
            maps:update_with(Val, fun(Indices) -> [Idx | Indices] end, [Idx], AccMap)
        end,
        #{},
        lists:zip(Arr, lists:seq(0, length(Arr) - 1)) % Create a list of {Value, Index} pairs
    ),
    % Step 2: For each value in TempMap, reverse its list of indices and convert it to a tuple.
    % Reversing makes the indices sorted ascending. Converting to tuple allows O(1) element access for binary search.
    maps:map(fun(_Val, Indices) -> list_to_tuple(lists:reverse(Indices)) end, TempMap).

query(DataMap, Left, Right, Value) ->
    case maps:find(Value, DataMap) of
        {ok, IndicesTuple} ->
            % If Value is found, IndicesTuple contains all its occurrences in sorted order.
            % We need to find the count of indices 'I' such that Left <= I <= Right.
            % This can be calculated as:
            % (count of I <= Right) - (count of I < Left)
            % Using binary search:
            % upper_bound(IndicesTuple, Right) gives the count of elements <= Right.
            % lower_bound(IndicesTuple, Left) gives the count of elements < Left.
            LowerBoundIdx = binary_search_lower_bound(IndicesTuple, Left),
            UpperBoundIdx = binary_search_upper_bound(IndicesTuple, Right),
            UpperBoundIdx - LowerBoundIdx
        _ ->
            % Value not found in the original array, so its frequency is 0.
            0
    end.

binary_search_lower_bound(Tuple, Target) ->
    binary_search_lower_bound(Tuple, Target, 0, tuple_size(Tuple)).

binary_search_lower_bound(_Tuple, _Target, Low, High) when Low >= High -> Low;
binary_search_lower_bound(Tuple, Target, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = element(Mid + 1, Tuple), % Tuples are 1-indexed in Erlang
    if
        Element < Target ->
            binary_search_lower_bound(Tuple, Target, Mid + 1, High);
        true -> % Element >= Target
            binary_search_lower_bound(Tuple, Target, Low, Mid)
    end.

binary_search_upper_bound(Tuple, Target) ->
    binary_search_upper_bound(Tuple, Target, 0, tuple_size(Tuple)).

binary_search_upper_bound(_Tuple, _Target, Low, High) when Low >= High -> Low;
binary_search_upper_bound(Tuple, Target, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = element(Mid + 1, Tuple), % Tuples are 1-indexed in Erlang
    if
        Element <= Target ->
            binary_search_upper_bound(Tuple, Target, Mid + 1, High);
        true -> % Element > Target
            binary_search_upper_bound(Tuple, Target, Low, Mid)
    end.