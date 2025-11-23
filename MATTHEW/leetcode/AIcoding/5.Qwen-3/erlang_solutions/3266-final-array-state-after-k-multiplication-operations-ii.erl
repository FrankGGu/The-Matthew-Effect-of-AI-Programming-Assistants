-module(final_array_state_after_k_multiplication_operations_ii).
-export([resultArray/2]).

resultArray(Nums, k) ->
    N = length(Nums),
    % Create a list of {Value, Index} pairs
    List = lists:zip(Nums, lists:seq(0, N-1)),
    % Sort the list by value and then by index
    Sorted = lists:sort(fun({A, I}, {B, J}) -> 
        if A < B -> true;
           A == B -> I < J;
           true -> false
        end
    end, List),
    % Initialize a result array with the original values
    Result = lists:copy(0, N),
    lists:foreach(fun({Val, Index}) -> lists:setelement(Index+1, Result, Val) end, Sorted),
    % Perform k operations
    perform_ops(Result, Sorted, k).

perform_ops(Result, Sorted, 0) ->
    Result;
perform_ops(Result, Sorted, K) ->
    % Find the smallest element in the current result
    Min = lists:min([lists:nth(I, Result) || I <- lists:seq(1, length(Result))]),
    % Find all indices where the value is equal to Min
    Indices = [I || I <- lists:seq(1, length(Result)), lists:nth(I, Result) == Min],
    % For each index, multiply the value by 2
    NewResult = lists:foldl(fun(I, Acc) ->
        lists:setelement(I, Acc, lists:nth(I, Acc) * 2)
    end, Result, Indices),
    % Re-sort the elements based on their new values and indices
    NewSorted = lists:sort(fun({A, I}, {B, J}) -> 
        if A < B -> true;
           A == B -> I < J;
           true -> false
        end
    end, lists:zip(NewResult, lists:seq(1, length(NewResult)))),
    % Recurse with K-1
    perform_ops(NewResult, NewSorted, K-1).