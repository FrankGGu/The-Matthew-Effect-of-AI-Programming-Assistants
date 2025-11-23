-module(solution).
-export([goodPairs/3]).

goodPairs(Nums1, Nums2, K) ->
    % Build frequency map for Nums2
    % Freq2 maps each unique value N from Nums2 to its count.
    Freq2 = lists:foldl(fun(N, Acc) ->
                                maps:update_counter(N, 1, Acc)
                        end, maps:new(), Nums2),

    % Calculate total good pairs by iterating through Nums1
    TotalGoodPairs = lists:foldl(fun(Num1, Acc) ->
                                         % Check if Num1 is divisible by K
                                         if Num1 rem K == 0 ->
                                                % If divisible, calculate Target = Num1 / K
                                                Target = Num1 div K,
                                                % Add to accumulator the count of Nums2 values that are divisors of Target
                                                Acc + count_divisors_in_freq2(Target, Freq2);
                                            true ->
                                                % If not divisible by K, no Nums2[j] can form a good pair with this Num1
                                                Acc
                                         end
                                 end, 0, Nums1),
    TotalGoodPairs.

count_divisors_in_freq2(Target, Freq2) ->
    % Start with 0 count
    InitialCount = 0,
    % Iterate from 1 up to the square root of Target to find divisors
    Limit = trunc(math:sqrt(Target)),
    count_divisors_in_freq2_loop(1, Limit, Target, Freq2, InitialCount).

count_divisors_in_freq2_loop(D, Limit, Target, Freq2, Acc) when D =< Limit ->
    if Target rem D == 0 ->
           % D is a divisor
           D1 = D,
           % Target / D is also a divisor
           D2 = Target div D,

           % Check D1 in Freq2
           NewAcc1 = case maps:find(D1, Freq2) of
                         {ok, C1} -> Acc + C1;
                         _ -> Acc
                     end,

           % Check D2 in Freq2, but only if D1 and D2 are different
           NewAcc2 = if D1 =/= D2 ->
                         case maps:find(D2, Freq2) of
                             {ok, C2} -> NewAcc1 + C2;
                             _ -> NewAcc1
                         end;
                     true -> NewAcc1
                     end,

           % Continue to the next potential divisor
           count_divisors_in_freq2_loop(D + 1, Limit, Target, Freq2, NewAcc2);
       true ->
           % D is not a divisor, continue with current accumulator
           count_divisors_in_freq2_loop(D + 1, Limit, Target, Freq2, Acc)
    end;
count_divisors_in_freq2_loop(_D, _Limit, _Target, _Freq2, Acc) ->
    Acc.