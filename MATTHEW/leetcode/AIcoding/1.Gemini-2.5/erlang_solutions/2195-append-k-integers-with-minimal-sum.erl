-spec minimal_k_sum(Nums :: [integer()], K :: integer()) -> integer().
minimal_k_sum(Nums, K) ->
    SortedUniqueNums = lists:usort(Nums),
    append_loop(SortedUniqueNums, K, 1, 0).

append_loop([], K, NextAvailableInt, CurrentSum) ->
    % No more numbers in Nums to skip. Add remaining K integers.
    % Sum of an arithmetic series: K * (2*A + K - 1) / 2
    % where A is the first term (NextAvailableInt)
    CurrentSum + K * (2 * NextAvailableInt + K - 1) div 2;
append_loop([N | Rest], K, NextAvailableInt, CurrentSum) when K > 0 ->
    % Calculate how many positive integers we can add before N
    % These are NextAvailableInt, NextAvailableInt + 1, ..., N - 1
    CountCanAdd = N - NextAvailableInt,

    if CountCanAdd > 0 ->
        % We can potentially add 'CountCanAdd' numbers.
        % However, we only need 'K' numbers in total, so we add min(K, CountCanAdd).
        CountToAdd = min(K, CountCanAdd),

        % Calculate the sum of 'CountToAdd' integers starting from 'NextAvailableInt'
        % Sum = Count * (2*FirstTerm + Count - 1) / 2
        SumToAdd = CountToAdd * (2 * NextAvailableInt + CountToAdd - 1) div 2,

        NewK = K - CountToAdd,
        NewSum = CurrentSum + SumToAdd,

        % After potentially adding numbers before N, we skip N itself (as it's in Nums)
        % and continue checking from N + 1.
        append_loop(Rest, NewK, N + 1, NewSum);
    true ->
        % CountCanAdd <= 0, meaning NextAvailableInt >= N.
        % This implies N is already "covered" by NextAvailableInt or we are past it.
        % So, we just skip N and continue checking from N + 1.
        append_loop(Rest, K, N + 1, CurrentSum)
    end;
append_loop(_, 0, _, CurrentSum) ->
    % K is 0, no more numbers to append
    CurrentSum.