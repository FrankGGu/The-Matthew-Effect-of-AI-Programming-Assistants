-module(solution).
-export([car_fleet_ii/1]).

car_fleet_ii(Cars) ->
    N = length(Cars),
    % Initialize an array for results, default -1.0.
    % Using the 'array' module for O(1) element access and updates.
    AnsArray = array:new([{size, N}, {fixed, true}, {default, -1.0}]),

    % The stack stores indices of cars that are potential collision candidates.
    % It's initialized as an empty list.
    Stack = [],

    % Iterate through car indices from N-1 down to 0 (right to left).
    % 'lists:foldl' is used to accumulate the updated AnsArray and Stack.
    {FinalAnsArray, _FinalStack} = lists:foldl(
        fun(I, {AccAnsArray, AccStack}) ->
            % Get position and speed for the current car I.
            % Erlang lists are 1-indexed, so we use I + 1.
            [PosI, SpeedI] = lists:nth(I + 1, Cars),

            % Find the collision time for car I by processing the current stack.
            % This helper function also returns the stack state after popping
            % cars that I will not collide with first.
            {CollisionTimeI, UpdatedStackForI} = find_collision_time(
                I, PosI, SpeedI, AccStack, Cars, AccAnsArray
            ),

            % Update the result array with the calculated collision time for car I.
            NewAnsArray = array:set(I, CollisionTimeI, AccAnsArray),

            % Push car I onto the stack for subsequent cars (cars with smaller indices).
            NewStack = [I | UpdatedStackForI],

            {NewAnsArray, NewStack}
        end,
        {AnsArray, Stack},
        lists:seq(N - 1, 0, -1) % Generate indices from N-1 down to 0.
    ),

    % Convert the final array of results to a list.
    array:to_list(FinalAnsArray).

find_collision_time(I, PosI, SpeedI, CurrentStack, Cars, AnsArray) ->
    case CurrentStack of
        [] ->
            % If the stack is empty, car I never collides with any car ahead of it.
            % Return -1.0 for collision time and an empty stack (as no cars were popped).
            {-1.0, []};
        [J | RestStack] ->
            % Get position and speed for the car J at the top of the stack.
            [PosJ, SpeedJ] = lists:nth(J + 1, Cars),

            if
                SpeedI =< SpeedJ ->
                    % Car I is slower than or has the same speed as car J.
                    % It will never catch car J. Therefore, J is not the car I collides with first.
                    % Pop J from the stack and continue checking with the next car on the stack.
                    find_collision_time(I, PosI, SpeedI, RestStack, Cars, AnsArray);
                true -> % SpeedI > SpeedJ
                    % Car I is faster than car J, so they can potentially collide.
                    % Calculate the time it would take for I to collide with J.
                    CollisionTimeIJ = (PosJ - PosI) / (SpeedI - SpeedJ),

                    % Get the already computed collision time for car J.
                    % This tells us if J itself collides with a car K further ahead.
                    AnsJ = array:get(J, AnsArray),

                    if
                        AnsJ =/= -1.0 andalso CollisionTimeIJ >= AnsJ ->
                            % Car J is already set to collide with some car K (AnsJ is not -1.0).
                            % If car I would collide with J *after* or *at the same time* J collides with K,
                            % then car I will effectively collide with the fleet formed by J and K (or just K).
                            % In this scenario, J is not the first car I collides with.
                            % Pop J from the stack and continue checking with the next car.
                            find_collision_time(I, PosI, SpeedI, RestStack, Cars, AnsArray);
                        true ->
                            % Car I collides with J first (either J doesn't collide, or I collides
                            % with J before J collides with K).
                            % This is the collision time for car I.
                            % The stack remains 'CurrentStack' because J is the car I collides with
                            % and thus remains on top of the stack for future cars.
                            {CollisionTimeIJ, CurrentStack}
                    end
            end
    end.