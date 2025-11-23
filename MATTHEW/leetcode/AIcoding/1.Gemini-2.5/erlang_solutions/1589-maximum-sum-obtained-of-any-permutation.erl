-module(solution).
-export([max_sum_range_query/2]).

max_sum_range_query(Nums, Requests) ->
    N = length(Nums),
    Modulo = 1000000007,

    % Step 1: Calculate frequencies using a difference array
    % Initialize an array of size N with zeros.
    FreqArray = array:new([{size, N}, {fixed, true}, {default, 0}]),

    % Process each request to update the difference array
    FreqArray1 = lists:foldl(
        fun([Start, End], AccArray) ->
            % Increment count at 'Start'
            AccArray1 = array:set(Start, array:get(Start, AccArray) + 1, AccArray),
            % Decrement count at 'End + 1' if it's within bounds
            if End + 1 < N ->
                array:set(End + 1, array:get(End + 1, AccArray1) - 1, AccArray1);
            true ->
                AccArray1
            end
        end,
        FreqArray,
        Requests
    ),

    % Step 2: Convert the difference array to actual frequencies using prefix sums
    FreqList = calculate_actual_frequencies(FreqArray1, N),

    % Step 3: Sort Nums and FreqList in descending order
    SortedNums = lists:sort(fun(A, B) -> A >= B end, Nums),
    SortedFreq = lists:sort(fun(A, B) -> A >= B end, FreqList),

    % Step 4: Calculate the maximum sum by multiplying the largest numbers
    % with the highest frequencies and summing them up, applying modulo.
    lists:foldl(
        fun({Num, Freq}, Acc) ->
            (Acc + Num * Freq) rem Modulo
        end,
        0,
        lists:zip(SortedNums, SortedFreq)
    ).

calculate_actual_frequencies(FreqArray, N) ->
    calculate_actual_frequencies_recursive(FreqArray, N, 0, 0, []).

calculate_actual_frequencies_recursive(_FreqArray, N, N, _CurrentSum, AccList) ->
    lists:reverse(AccList);
calculate_actual_frequencies_recursive(FreqArray, N, Index, CurrentSum, AccList) ->
    Val = array:get(Index, FreqArray),
    NewSum = CurrentSum + Val,
    calculate_actual_frequencies_recursive(FreqArray, N, Index + 1, NewSum, [NewSum | AccList]).