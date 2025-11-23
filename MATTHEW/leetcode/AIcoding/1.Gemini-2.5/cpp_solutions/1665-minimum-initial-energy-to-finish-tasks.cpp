#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumInitialEnergy(std::vector<std::vector<int>>& tasks) {
        // Sort tasks based on the difference (minimum_i - actual_i) in descending order.
        // This ensures that tasks which require a high minimum energy but consume relatively less
        // actual energy are prioritized. Such tasks are "harder to start" but "easier to finish"
        // in terms of energy balance, so doing them earlier helps maintain energy for subsequent tasks.
        std::sort(tasks.begin(), tasks.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            // Sort by (minimum - actual) in descending order.
            // If a.minimum - a.actual is greater than b.minimum - b.actual, 'a' comes before 'b'.
            return (a[1] - a[0]) > (b[1] - b[0]);
        });

        long long initial_energy_required = 0;
        long long current_energy_balance = 0;

        for (const auto& task : tasks) {
            int actual = task[0];
            int minimum = task[1];

            // If our current energy balance is less than the minimum required to start this task,
            // we must have started with more initial energy.
            // The amount needed is (minimum - current_energy_balance).
            if (current_energy_balance < minimum) {
                initial_energy_required += (minimum - current_energy_balance);
                // After adding the necessary initial energy, our balance is now exactly 'minimum'
                // to start this task.
                current_energy_balance = minimum;
            }

            // Perform the task: subtract the actual energy consumed.
            current_energy_balance -= actual;
        }

        return static_cast<int>(initial_energy_required);
    }
};