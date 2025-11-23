-module(solution).
-export([minNumberOfFrogs/1]).

minNumberOfFrogs(CroakOfFrogs) ->
    % State tuple: {C_count, R_count, O_count, A_count, ActiveFrogs, MaxFrogs}
    % C_count: frogs that said 'c' but not 'r'
    % R_count: frogs that said 'r' but not 'o'
    % O_count: frogs that said 'o' but not 'a'
    % A_count: frogs that said 'a' but not 'k'
    % ActiveFrogs: total frogs currently croaking (started 'c', not finished 'k')
    % MaxFrogs: maximum number of active frogs observed, which is the answer
    InitialState = {0, 0, 0, 0, 0, 0},

    % Process each character in the input string
    FinalState = lists:foldl(fun process_char/2, InitialState, string:to_list(CroakOfFrogs)),

    % Check the final state to determine the result
    case FinalState of
        {C, R, O, A, Active, Max} when C == 0 andalso R == 0 andalso O == 0 andalso A == 0 andalso Active == 0 ->
            Max; % All croaks completed successfully, return max frogs needed
        _ ->
            -1 % Invalid sequence (e.g., unmatched characters, invalid characters, or unfinished croaks)
    end.

process_char(_, {C, R, O, A, Active, Max}) when C < 0 orelse R < 0 orelse O < 0 orelse A < 0 ->
    {C, R, O, A, Active, Max}; % Propagate the error state
process_char($c, {C, R, O, A, Active, Max}) ->
    NewC = C + 1,
    NewActive = Active + 1,
    NewMax = max(Max, NewActive),
    {NewC, R, O, A, NewActive, NewMax};
process_char($r, {C, R, O, A, Active, Max}) ->
    if C > 0 ->
        NewC = C - 1,
        NewR = R + 1,
        {NewC, NewR, O, A, Active, Max};
    true -> % Invalid: 'r' without a preceding 'c'
        {-1, R, O, A, Active, Max} % Signal error by setting C to -1
    end;
process_char($o, {C, R, O, A, Active, Max}) ->
    if R > 0 ->
        NewR = R - 1,
        NewO = O + 1,
        {C, NewR, NewO, A, Active, Max};
    true -> % Invalid: 'o' without a preceding 'r'
        {C, -1, O, A, Active, Max} % Signal error by setting R to -1
    end;
process_char($a, {C, R, O, A, Active, Max}) ->
    if O > 0 ->
        NewO = O - 1,
        NewA = A + 1,
        {C, R, NewO, NewA, Active, Max};
    true -> % Invalid: 'a' without a preceding 'o'
        {C, R, -1, A, Active, Max} % Signal error by setting O to -1
    end;
process_char($k, {C, R, O, A, Active, Max}) ->
    if A > 0 ->
        NewA = A - 1,
        NewActive = Active - 1,
        {C, R, O, NewA, NewActive, Max};
    true -> % Invalid: 'k' without a preceding 'a'
        {C, R, O, -1, Active, Max} % Signal error by setting A to -1
    end;
process_char(_, {C, R, O, A, Active, Max}) ->
    % Any other character is invalid
    {-1, -1, -1, -1, Active, Max}. % Signal error with all counts as -1