#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    long long taskSchedulerII(std::vector<int>& tasks, int space) {
        std::unordered_map<int, long long> last_day;
        long long current_day = 0;

        for (int task : tasks) {
            if (last_day.count(task)) {
                long long last_occurrence = last_day[task];
                current_day = std::max(current_day + 1, last_occurrence + space + 1);
            } else {
                current_day++;
            }
            last_day[task] = current_day;
        }

        return current_day;
    }
};