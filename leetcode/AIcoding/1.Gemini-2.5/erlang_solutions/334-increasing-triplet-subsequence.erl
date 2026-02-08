-module(solution).
-export([increasing_triplet/1]).

-spec increasing_triplet(Nums :: [integer()]) -> boolean().
increasing_triplet(Nums) ->
    % Initialize min1 and min2 to positive infinity.
    % min1 will store the smallest number encountered so far.
    % min2 will store the second smallest number encountered so far,
    % which is greater than min1.
    check_triplet(Nums, float('infinity'), float('infinity')).

check_triplet([], _Min1, _Min2) ->
    % If we reach the end of the list, no triplet was found.
    false;
check_triplet([N|Rest], Min1, Min2) ->
    if
        N > Min2 ->
            % If the current number N is greater than min2,
            % we have found an increasing triplet: min1 < min2 < N.
            true;
        N > Min1 ->
            % If N is greater than min1 but not greater than min2 (i.e., min1 < N <= min2),
            % we update min2 to N. This is because N is a smaller candidate for the
            % second element of a triplet, potentially allowing us to find a triplet sooner.
            check_triplet(Rest, Min1, N);
        true -> % N <= Min1
            % If N is less than or equal to min1,
            % we update min1 to N. This is because N is a smaller candidate for the
            % first element of a triplet.
            check_triplet(Rest, N, Min2)
    end.