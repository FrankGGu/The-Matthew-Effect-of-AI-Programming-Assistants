#include <vector>
#include <numeric>
#include <algorithm>
#include <functional>

class Solution {
public:
    // Helper function to check if all tasks can be completed within 'max_time' using 'k' workers.
    // This function uses a Depth First Search (DFS) with backtracking and pruning.
    bool check(long long max_time, const std::vector<int>& tasks_original, int k) {
        std::vector<long long> worker_loads(k, 0); // Stores current load for each worker

        // Create a mutable copy of tasks and sort them in descending order.
        // Sorting tasks in descending order often helps prune the search space earlier in DFS.
        std::vector<int> tasks = tasks_original;
        std::sort(tasks.rbegin(), tasks.rend());

        // DFS function to try assigning tasks to workers
        std::function<bool(int)> dfs = 
            [&](int task_idx) {
            // Base case: If all tasks have been assigned, a valid assignment is found.
            if (task_idx == tasks.size()) {
                return true;
            }

            int current_task = tasks[task_idx];

            // Try assigning the current task to each of the 'k' workers
            for (int i = 0; i < k; ++i) {
                // Pruning 1: If assigning the current task to worker 'i' would exceed 'max_time', skip this worker.
                if (worker_loads[i] + current_task > max_time) {
                    continue;
                }

                // Pruning 2: If this worker has the same load as the previous worker,
                // and the previous worker was already tried for this task,
                // then trying this worker would lead to a redundant search path.
                // This is valid because workers are indistinguishable.
                if (i > 0 && worker_loads[i] == worker_loads[i-1]) {
                    continue; 
                }

                // Assign task to worker 'i'
                worker_loads[i] += current_task;

                // Recursively try to assign the next task
                if (dfs(task_idx + 1)) {
                    return true; // If a valid assignment is found down this path, propagate true
                }

                // Backtrack: Remove the current task from worker 'i' to try other assignments
                worker_loads[i] -= current_task;

                // Pruning 3: If we tried to assign current_task to worker 'i'
                // and it failed (dfs(task_idx + 1) returned false), AND worker 'i' was empty
                // before this attempt (meaning worker_loads[i] is 0 after backtracking),
                // then trying any other currently empty worker would be redundant.
                // If it failed for one empty worker, it will fail for another.
                if (worker_loads[i] == 0) { 
                    break; // No need to try other empty workers
                }
            }
            return false; // No worker could take the current task and lead to a solution
        };

        return dfs(0);
    }

    int minimumTimeRequired(std::vector<int>& tasks, int k) {
        long long left = 0; // The minimum possible maximum time (longest single task)
        long long right = 0; // The maximum possible maximum time (sum of all tasks if k=1)

        for (int task : tasks) {
            left = std::max(left, (long long)task);
            right += task;
        }

        long long ans = right; // Initialize answer with the maximum possible time

        // Binary search for the minimum maximum time
        while (left <= right) {
            long long mid = left + (right - left) / 2;
            if (check(mid, tasks, k)) {
                ans = mid;         // 'mid' is a possible maximum time, try for a smaller one
                right = mid - 1;
            } else {
                left = mid + 1;    // 'mid' is not achievable, need more time
            }
        }
        return ans;
    }
};