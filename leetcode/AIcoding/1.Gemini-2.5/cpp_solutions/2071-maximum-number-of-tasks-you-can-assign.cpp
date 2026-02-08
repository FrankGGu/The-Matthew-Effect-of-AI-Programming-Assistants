#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    bool check(int k, const std::vector<int>& tasks, const std::vector<int>& workers, int pills, int strength) {
        if (k == 0) {
            return true;
        }
        if (k > tasks.size() || k > workers.size()) {
            return false;
        }

        std::multiset<int> available_workers;
        for (int i = 0; i < k; ++i) {
            available_workers.insert(workers[workers.size() - 1 - i]);
        }

        int current_pills = pills;

        for (int i = 0; i < k; ++i) {
            int current_task = tasks[i];

            // Try to find a worker who can complete the task without a pill
            auto it = available_workers.lower_bound(current_task);

            if (it != available_workers.end()) {
                available_workers.erase(it);
            } else {
                // If no worker can do it without a pill, try with a pill
                if (current_pills > 0) {
                    auto it_pill = available_workers.lower_bound(current_task - strength);
                    if (it_pill != available_workers.end()) {
                        available_workers.erase(it_pill);
                        current_pills--;
                    } else {
                        // No worker can do it even with a pill
                        return false;
                    }
                } else {
                    // No pills left
                    return false;
                }
            }
        }
        return true;
    }

    int maxTaskAssign(std::vector<int>& tasks, std::vector<int>& workers, int pills, int strength) {
        std::sort(tasks.begin(), tasks.end());
        std::sort(workers.begin(), workers.end());

        int low = 0;
        int high = std::min(tasks.size(), workers.size());
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, tasks, workers, pills, strength)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }
};