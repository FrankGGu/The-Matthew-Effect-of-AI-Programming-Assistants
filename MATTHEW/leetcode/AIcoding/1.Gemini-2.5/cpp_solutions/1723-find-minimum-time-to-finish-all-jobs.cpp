#include <vector>
#include <numeric>
#include <algorithm>
#include <functional> // For std::greater

class Solution {
public:
    // Helper function for backtracking to check if a given max_time is feasible
    // job_idx: current job to assign
    // worker_loads: vector storing current total time for each worker
    // max_time: the maximum allowed time for any single worker
    // jobs: the original list of job times
    bool can_assign_jobs(int job_idx, std::vector<int>& worker_loads, int max_time, const std::vector<int>& jobs) {
        // Base case: If all jobs have been assigned, it's a success
        if (job_idx == jobs.size()) {
            return true;
        }

        // Try assigning the current job (jobs[job_idx]) to each worker
        for (int i = 0; i < worker_loads.size(); ++i) {
            // If assigning the current job to worker 'i' does not exceed max_time
            if (worker_loads[i] + jobs[job_idx] <= max_time) {
                worker_loads[i] += jobs[job_idx]; // Assign job to worker 'i'

                // Recursively try to assign the next job
                if (can_assign_jobs(job_idx + 1, worker_loads, max_time, jobs)) {
                    return true; // If successful, propagate success
                }

                worker_loads[i] -= jobs[job_idx]; // Backtrack: unassign job from worker 'i'
            }

            // Optimization: If worker 'i' is currently idle (load is 0)
            // and we tried assigning the current job to them, but it failed
            // (meaning the recursive call returned false), then assigning
            // this job to any other *currently idle* worker would be symmetric
            // and also fail. So, we can break early.
            // This condition checks worker_loads[i] AFTER backtracking.
            // If worker_loads[i] was 0 before adding jobs[job_idx], it will be 0 after subtracting.
            // If it's 0 after backtracking, it means it was an empty worker.
            if (worker_loads[i] == 0) {
                break;
            }
        }
        return false; // No valid assignment found for the current job
    }

    int minimumTimeRequired(std::vector<int>& jobs, int k) {
        // Sort jobs in descending order. This helps pruning in backtracking
        // by trying larger jobs first, which can lead to earlier failures
        // if a max_time is too small.
        std::sort(jobs.begin(), jobs.end(), std::greater<int>());

        // Binary search for the minimum possible maximum time
        int low = 0;
        int high = 0;
        // Initialize low with the largest single job time (minimum possible max time)
        // Initialize high with the sum of all job times (maximum possible max time)
        for (int job_time : jobs) {
            low = std::max(low, job_time);
            high += job_time;
        }

        int ans = high; // Initialize answer with the upper bound

        // Perform binary search
        while (low <= high) {
            int mid = low + (high - low) / 2; // Current guess for max_time

            std::vector<int> worker_loads(k, 0); // Initialize k workers with 0 load
            if (can_assign_jobs(0, worker_loads, mid, jobs)) {
                // If it's possible to finish all jobs within 'mid' time,
                // 'mid' is a potential answer. Try for a smaller time.
                ans = mid;
                high = mid - 1;
            } else {
                // 'mid' time is not enough; need more time.
                low = mid + 1;
            }
        }

        return ans;
    }
};