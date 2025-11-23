#include <vector>
#include <numeric>
#include <algorithm>
#include <functional>

class Solution {
public:
    bool check(long long max_time, int k, const std::vector<int>& jobs, std::vector<long long>& worker_loads, int job_idx) {
        if (job_idx == jobs.size()) {
            return true;
        }

        for (int i = 0; i < k; ++i) {
            if (worker_loads[i] + jobs[job_idx] <= max_time) {
                worker_loads[i] += jobs[job_idx];
                if (check(max_time, k, jobs, worker_loads, job_idx + 1)) {
                    return true;
                }
                worker_loads[i] -= jobs[job_idx];
            }

            if (worker_loads[i] == 0) {
                break;
            }
        }
        return false;
    }

    int minimumTimeRequired(std::vector<int>& jobs, int k) {
        std::sort(jobs.rbegin(), jobs.rend());

        long long low = 0;
        long long high = 0;
        for (int job_time : jobs) {
            low = std::max(low, (long long)job_time);
            high += job_time;
        }

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            std::vector<long long> worker_loads(k, 0);

            if (check(mid, k, jobs, worker_loads, 0)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
};