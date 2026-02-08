-module(solution).
-export([sum_odd_length_subarrays/1]).

sum_odd_length_subarrays(Arr) ->
    N = length(Arr),
    {_FinalIndex, TotalSum} = lists:foldl(fun(Element, {I, AccSum}) ->
                                            % Calculate the number of times the current element appears in odd-length subarrays.
                                            % I is the 0-based index of the current element.

                                            % Number of elements to the left of (and including) the current element.
                                            LeftCount = I + 1,
                                            % Number of elements to the right of (and including) the current element.
                                            RightCount = N - I,

                                            % Number of odd-length subarrays starting at or before I.
                                            % Equivalent to ceil(LeftCount / 2)
                                            LeftOdd = (LeftCount + 1) div 2,
                                            % Number of even-length subarrays starting at or before I.
                                            % Equivalent to floor(LeftCount / 2)
                                            LeftEven = LeftCount div 2,

                                            % Number of odd-length subarrays ending at or after I.
                                            % Equivalent to ceil(RightCount / 2)
                                            RightOdd = (RightCount + 1) div 2,
                                            % Number of even-length subarrays ending at or after I.
                                            % Equivalent to floor(RightCount / 2)
                                            RightEven = RightCount div 2,

                                            % An odd-length subarray containing Element can be formed in two ways:
                                            % 1. Start index (j) and end index (k) such that (i - j) is even AND (k - i) is even.
                                            %    This means (k - j + 1) = (k - i) + (i - j) + 1 = even + even + 1 = odd.
                                            %    Number of ways: LeftOdd * RightOdd
                                            % 2. Start index (j) and end index (k) such that (i - j) is odd AND (k - i) is odd.
                                            %    This means (k - j + 1) = (k - i) + (i - j) + 1 = odd + odd + 1 = odd.
                                            %    Number of ways: LeftEven * RightEven
                                            Occurrences = LeftOdd * RightOdd + LeftEven * RightEven,

                                            NewAccSum = AccSum + Element * Occurrences,
                                            {I + 1, NewAccSum}
                                    end, {0, 0}, Arr),
    TotalSum.