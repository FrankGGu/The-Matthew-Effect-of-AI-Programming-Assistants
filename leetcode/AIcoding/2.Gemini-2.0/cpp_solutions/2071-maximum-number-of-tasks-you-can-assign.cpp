#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTasks(vector<int>& tasks, vector<int>& workers, int pills, int strength) {
        sort(tasks.begin(), tasks.end());
        sort(workers.begin(), workers.end());

        int left = 0, right = min(tasks.size(), workers.size());
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(tasks, workers, pills, strength, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }

private:
    bool check(vector<int>& tasks, vector<int>& workers, int pills, int strength, int k) {
        vector<int> temp_workers;
        for (int i = workers.size() - 1; i >= workers.size() - k; --i) {
            temp_workers.push_back(workers[i]);
        }
        sort(temp_workers.begin(), temp_workers.end());

        int task_idx = k - 1;
        int worker_idx = k - 1;

        while (task_idx >= 0) {
            if (temp_workers[worker_idx] >= tasks[task_idx]) {
                worker_idx--;
                task_idx--;
            } else {
                if (pills == 0) return false;
                if (temp_workers[worker_idx] + strength >= tasks[task_idx]) {
                    pills--;
                    worker_idx--;
                    task_idx--;
                } else {
                    return false;
                }
            }
        }

        return true;
    }
};