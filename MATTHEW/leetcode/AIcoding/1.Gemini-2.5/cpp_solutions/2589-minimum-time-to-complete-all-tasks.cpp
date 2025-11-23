#include <vector>
#include <algorithm>

class Solution {
public:
    int minTime(std::vector<std::vector<int>>& tasks) {
        std::sort(tasks.begin(), tasks.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[1] != b[1]) {
                return a[1] < b[1];
            }
            return a[0] < b[0];
        });

        std::vector<bool> cpu_time(2001, false);
        int total_time_spent = 0;

        for (const auto& task : tasks) {
            int start = task[0];
            int end = task[1];
            int duration = task[2];

            int covered_duration = 0;
            for (int t = start; t <= end; ++t) {
                if (cpu_time[t]) {
                    covered_duration++;
                }
            }

            int needed_duration = duration - covered_duration;

            for (int t = end; t >= start && needed_duration > 0; --t) {
                if (!cpu_time[t]) {
                    cpu_time[t] = true;
                    total_time_spent++;
                    needed_duration--;
                }
            }
        }

        return total_time_spent;
    }
};