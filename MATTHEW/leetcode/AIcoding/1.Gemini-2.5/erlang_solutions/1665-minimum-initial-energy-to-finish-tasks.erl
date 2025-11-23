-module(solution).
-export([minimum_initial_energy/1]).

minimum_initial_energy(Tasks) ->
    % Sort tasks by (minimum_required - actual_cost) in descending order.
    % This prioritizes tasks that require a larger 'net' energy.
    SortedTasks = lists:sort(fun([AC1, MR1], [AC2, MR2]) ->
                                 (MR1 - AC1) > (MR2 - AC2)
                             end, Tasks),

    % Use lists:foldl to iterate through sorted tasks and calculate the minimum initial energy.
    % The accumulator is a tuple {CurrentEnergy, MinInitialEnergy}.
    % CurrentEnergy tracks the energy we would have if we started with MinInitialEnergy.
    % MinInitialEnergy accumulates the total initial energy required.
    {_FinalCurrentEnergy, MinInitialEnergy} = lists:foldl(
        fun([ActualCost, MinimumRequired], {CurrentEnergy, AccMinInitialEnergy}) ->
            % Calculate how much additional energy is needed to meet the MinimumRequired
            % for the current task. If CurrentEnergy is already sufficient, Needed is 0.
            Needed = max(0, MinimumRequired - CurrentEnergy),

            % Add the 'Needed' energy to the total minimum initial energy.
            UpdatedAccMinInitialEnergy = AccMinInitialEnergy + Needed,

            % The energy we have before executing this task is CurrentEnergy + Needed.
            % This effectively ensures we have at least MinimumRequired energy.
            EnergyBeforeTask = CurrentEnergy + Needed,

            % After executing the task, deduct its actual cost.
            EnergyAfterTask = EnergyBeforeTask - ActualCost,

            % Return the updated current energy and accumulated minimum initial energy.
            {EnergyAfterTask, UpdatedAccMinInitialEnergy}
        end,
        {0, 0}, % Initial accumulator: {CurrentEnergy, MinInitialEnergy}
        SortedTasks
    ),
    MinInitialEnergy.

max(A, B) when A >= B -> A;
max(A, B) -> B.