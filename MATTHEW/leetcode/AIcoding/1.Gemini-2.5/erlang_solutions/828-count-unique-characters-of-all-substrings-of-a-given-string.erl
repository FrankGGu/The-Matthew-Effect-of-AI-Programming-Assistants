-module(solution).
-export([uniqueLetterString/1]).

uniqueLetterString(S) ->
    N = length(S),
    Modulo = 1_000_000_007,

    % Initialize positions: a tuple of 26 queues.
    % Each queue stores indices for a character.
    % Start with -1 for boundary conditions.
    InitialQueues = list_to_tuple(lists:duplicate(26, queue:in(-1, queue:new()))),

    % First pass: populate queues with character indices
    % Fold over the string to update the queues tuple.
    % Acc: {CurrentIndex, PositionsTupleOfQueues}
    {_, FinalQueues} = lists:foldl(
        fun(Char, {Index, AccQueues}) ->
            CharIdx = Char - $A, % Convert character to 0-25 index
            CurrentCharQueue = element(CharIdx + 1, AccQueues), % +1 because tuple indices are 1-based
            NewCharQueue = queue:in(Index, CurrentCharQueue), % Add current index to the queue
            NewAccQueues = setelement(CharIdx + 1, AccQueues, NewCharQueue), % Update the tuple
            {Index + 1, NewAccQueues} % Move to next index
        end,
        {0, InitialQueues}, % Initial state: index 0, initial queues
        S
    ),

    % Second pass: add N (string length) to all queues for right boundary conditions
    FinalQueuesWithN = list_to_tuple(
        lists:map(
            fun(CharQueue) ->
                queue:in(N, CharQueue) % Add N to the end of each queue
            end,
            tuple_to_list(FinalQueues) % Convert tuple to list for map, then back to tuple
        )
    ),

    % Third pass: calculate total sum
    TotalSum = lists:foldl(
        fun(CharQueue, AccSum) ->
            % Convert each character's queue to a list for easier processing
            PositionsList = queue:to_list(CharQueue),
            % Calculate contribution for this character and add to total sum
            calculate_char_contribution(PositionsList, AccSum, Modulo)
        end,
        0, % Initial total sum
        tuple_to_list(FinalQueuesWithN) % Iterate through all character position lists
    ),
    TotalSum.

calculate_char_contribution(PositionsList, AccSum, Modulo) ->
    calculate_char_contribution_recursive(PositionsList, AccSum, Modulo).

calculate_char_contribution_recursive([_], AccSum, _Modulo) ->
    AccSum;
calculate_char_contribution_recursive([_Prev, _Current], AccSum, _Modulo) ->
    AccSum;
calculate_char_contribution_recursive([Prev, Current, Next | Rest], AccSum, Modulo) ->
    % LeftCount: number of choices for the start index (l)
    LeftCount = Current - Prev,
    % RightCount: number of choices for the end index (r)
    RightCount = Next - Current,

    % Contribution of 'Current' character being unique in substrings
    % (Current - Prev) * (Next - Current)
    Contribution = (LeftCount * RightCount) rem Modulo,

    % Add to accumulator and apply modulo
    NewAccSum = (AccSum + Contribution) rem Modulo,

    % Continue with the rest of the list
    calculate_char_contribution_recursive([Current, Next | Rest], NewAccSum, Modulo).