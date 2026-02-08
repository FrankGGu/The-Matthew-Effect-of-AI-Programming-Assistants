-module(solution).
-export([getStrongest/2]).

getStrongest(Arr, K) ->
    % 1. Sort the input array to find the median
    SortedArr = lists:sort(Arr),
    N = length(SortedArr),
    MedianIndex = (N - 1) div 2, % Integer division for 0-indexed median
    Median = lists:nth(MedianIndex + 1, SortedArr), % lists:nth is 1-indexed

    % 3. Calculate strength for each element and create a list of {Strength, Value} tuples
    StrengthValueTuples = lists:map(fun(X) -> {abs(X - Median), X} end, Arr),

    % 5. Sort this list based on strength (descending) and then value (descending) for ties
    SortedByStrength = lists:sort(fun({SA, VA}, {SB, VB}) ->
                                          if SA > SB -> true;  % SA is stronger, so {SA, VA} comes before {SB, VB}
                                             SA < SB -> false; % SB is stronger, so {SB, VB} comes before {SA, VA}
                                             true -> VA >= VB  % Strengths are equal, VA is stronger or equal, so {SA, VA} comes before {SB, VB}
                                          end
                                  end, StrengthValueTuples),

    % 6. Take the first K elements
    TopKTuples = lists:sublist(SortedByStrength, K),

    % 7. Extract just the values from these K elements
    lists:map(fun({_S, V}) -> V end, TopKTuples).