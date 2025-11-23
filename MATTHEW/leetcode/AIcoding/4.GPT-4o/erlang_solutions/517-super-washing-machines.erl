-module(solution).
-export([find_min_moves/1]).

%% Function to find minimum number of moves to make all washing machines have the same number of dresses.
-spec find_min_moves([integer()]) -> integer().
find_min_moves(Machines) ->
    TotalDresses = lists:sum(Machines),
    NumMachines = length(Machines),
    
    %% If the total dresses can't be evenly distributed, return -1.
    case TotalDresses rem NumMachines of
        0 ->
            Target = TotalDresses div NumMachines,
            %% Calculate moves by iterating through the array.
            find_min_moves_helper(Machines, Target, 0, 0);
        _ -> -1
    end.

%% Helper function to calculate the moves.
-spec find_min_moves_helper([integer()], integer(), integer(), integer()) -> integer().
find_min_moves_helper([], _, MaxMove, _Rest) -> MaxMove;
find_min_moves_helper([Head | Tail], Target, MaxMove, CarryOver) ->
    %% The current move for this machine is the absolute difference from the target.
    NewCarryOver = CarryOver + Head - Target,
    MaxMove1 = max(MaxMove, abs(NewCarryOver)),
    MaxMove2 = max(MaxMove1, Head - Target),
    find_min_moves_helper(Tail, Target, MaxMove2, NewCarryOver).
