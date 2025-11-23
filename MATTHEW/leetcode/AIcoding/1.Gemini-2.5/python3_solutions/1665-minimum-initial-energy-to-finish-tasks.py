class Solution:
    def minimumEffort(self, tasks: list[list[int]]) -> int:
        # Sort tasks by the difference (minimum_required - actual_cost) in descending order.
        # This greedy strategy prioritizes tasks that are "more demanding relative to their cost".
        # Tasks with a larger (minimum_required - actual_cost) value are those that either
        # require a very high minimum energy while consuming little, or consume a lot but
        # require an even higher minimum energy. Processing these earlier helps to maintain
        # a higher energy level for subsequent tasks that might also have high minimum requirements.
        tasks.sort(key=lambda x: x[1] - x[0], reverse=True)

        # min_initial_energy stores the total minimum initial energy required.
        min_initial_energy = 0
        # current_energy tracks the energy level we would have if we started with
        # min_initial_energy and completed all preceding tasks.
        current_energy = 0

        for actual_cost, minimum_required in tasks:
            # If our current energy level is less than the minimum required for this task,
            # we must increase our initial energy to meet this requirement.
            if current_energy < minimum_required:
                # Calculate the deficit: how much more energy we need.
                deficit = minimum_required - current_energy
                # Add this deficit to our total minimum initial energy.
                min_initial_energy += deficit
                # Conceptually, our current energy level is boosted to meet the requirement.
                current_energy += deficit

            # After ensuring we have enough energy (either naturally or by boosting initial energy),
            # we perform the task, which consumes 'actual_cost' energy.
            current_energy -= actual_cost

        return min_initial_energy