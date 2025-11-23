-module(solution).
-export([longest_fib_subseq/1]).

longest_fib_subseq(A) ->
    N = length(A),
    case N < 3 of
        true -> 0;
        false ->
            % Create a map for O(1) average time lookup of value to its index
            ValToIndexMap = maps:from_list(lists:zip(A, lists:seq(0, N - 1))),

            % dp map stores {I, J} -> Length, where Length is the length of the
            % longest Fibonacci-like subsequence ending with A[I] and A[J].
            InitialDp = maps:new(),

            % Start the outer loop (for J)
            {_FinalDp, MaxLen} = longest_fib_subseq_outer_loop(A, N, ValToIndexMap, InitialDp, 0, 1),
            MaxLen
    end.

longest_fib_subseq_outer_loop(A, N, ValToIndexMap, Dp, MaxLen, J) when J < N ->
    % Inner loop for I (index of the third-to-last element)
    {UpdatedDp, CurrentMaxLen} = longest_fib_subseq_inner_loop(A, N, ValToIndexMap, Dp, MaxLen, J, 0),
    longest_fib_subseq_outer_loop(A, N, ValToIndexMap, UpdatedDp, CurrentMaxLen, J + 1);
longest_fib_subseq_outer_loop(_A, _N, _ValToIndexMap, Dp, MaxLen, _J) ->
    % Base case: J has reached N, return the final dp map and max length
    {Dp, MaxLen}.

longest_fib_subseq_inner_loop(A, N, ValToIndexMap, Dp, MaxLen, J, I) when I < J ->
    % Get elements A[J] and A[I] (using 1-based indexing for lists:nth)
    AJ = lists:nth(J + 1, A),
    AI = lists:nth(I + 1, A),

    % Calculate the value of the previous element (A[K])
    PrevVal = AJ - AI,

    {NewDp, CurrentLen} =
        % Check if PrevVal is a valid preceding element:
        % 1. PrevVal must be less than AI (A[K] < A[I]) to ensure K < I
        % 2. PrevVal must exist in the input array A
        case PrevVal < AI andalso maps:is_key(PrevVal, ValToIndexMap) of
            true ->
                % Get the index K of PrevVal
                K = maps:get(PrevVal, ValToIndexMap),

                % The length of the subsequence ending with A[K] and A[I]
                % If {K, I} is not in Dp, it means A[K], A[I] form a base pair of length 2.
                PrevLen = maps:get({K, I}, Dp, 2),

                % Current length is PrevLen + 1 (for A[J])
                Len = PrevLen + 1,

                % Update dp map and return the new length
                {maps:put({I, J}, Len, Dp), Len};
            false ->
                % If PrevVal is not valid, A[I] and A[J] form a new base pair of length 2.
                % This pair cannot extend a previous Fibonacci sequence in the required way.
                {maps:put({I, J}, 2, Dp), 2}
        end,

    % Update MaxLen only if CurrentLen is 3 or more (as per problem definition)
    NewMaxLen = case CurrentLen >= 3 of
                    true -> max(MaxLen, CurrentLen);
                    false -> MaxLen
                end,

    % Continue inner loop with updated dp map and max length
    longest_fib_subseq_inner_loop(A, N, ValToIndexMap, NewDp, NewMaxLen, J, I + 1);
longest_fib_subseq_inner_loop(_A, _N, _ValToIndexMap, Dp, MaxLen, _J, _I) ->
    % Base case: I has reached J, return the final dp map and max length for this J
    {Dp, MaxLen}.