-module(solution).
-export([getKth/3]).

getKth(Lo, Hi, K) ->
    % Generate the list of integers in the range [Lo, Hi].
    Numbers = lists:seq(Lo, Hi),

    % Calculate power values for each number in the range,
    % using a shared memoization map to avoid redundant computations.
    % The result is a list of {PowerValue, OriginalNumber} tuples.
    PowerTuples = calculate_power_values_for_range(Numbers, #{}),

    % Sort the list of tuples. Erlang's lists:sort sorts by the first
    % element, then the second, which perfectly matches the problem's
    % sorting criteria (power value ascending, then number ascending).
    SortedTuples = lists:sort(PowerTuples),

    % Retrieve the K-th element from the sorted list.
    % lists:nth/2 is 1-indexed, matching the problem's K.
    {_Power, Result} = lists:nth(K, SortedTuples),
    Result.

-spec calculate_power_values_for_range(list(integer()), map()) -> list({integer(), integer()}).
calculate_power_values_for_range([], _Memo) -> [];
calculate_power_values_for_range([N | Rest], Memo) ->
    {Power, UpdatedMemo} = get_power_value(N, Memo),
    [{Power, N} | calculate_power_values_for_range(Rest, UpdatedMemo)].

-spec get_power_value(integer(), map()) -> {integer(), map()}.
get_power_value(1, Memo) ->
    % Base case: Power value of 1 is 0. Store it in memo.
    {0, maps:put(1, 0, Memo)};
get_power_value(N, Memo) ->
    % Check if the power value for N is already in the memoization map.
    case maps:find(N, Memo) of
        {ok, Power} ->
            % If found, return the stored value and the current memo map.
            {Power, Memo};
        error ->
            % If not found, calculate it recursively.
            NextN = if N rem 2 == 0 -> N div 2;
                       true -> 3 * N + 1
                    end,
            % Recursively get the power value for NextN and its updated memo map.
            {NextPower, IntermediateMemo} = get_power_value(NextN, Memo),
            % The power value for N is 1 (for the current step) + NextPower.
            Power = 1 + NextPower,
            % Store the newly calculated power value for N in the memo map.
            {Power, maps:put(N, Power, IntermediateMemo)}
    end.