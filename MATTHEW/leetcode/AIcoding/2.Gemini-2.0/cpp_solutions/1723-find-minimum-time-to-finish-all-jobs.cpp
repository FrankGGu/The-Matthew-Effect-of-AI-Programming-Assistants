#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTimeRequired(vector<int>& jobs, int k) {
        int n = jobs.size();
        int left = 0, right = 0;
        for (int job : jobs) {
            right += job;
            left = max(left, job);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canFinish(jobs, k, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

private:
    bool canFinish(vector<int>& jobs, int k, int maxTime) {
        vector<int> workers(k, 0);
        return backtrack(jobs, 0, workers, maxTime);
    }

    bool backtrack(vector<int>& jobs, int index, vector<int>& workers, int maxTime) {
        if (index == jobs.size()) {
            return true;
        }

        for (int i = 0; i < workers.size(); ++i) {
            if (workers[i] + jobs[index] <= maxTime) {
                workers[i] += jobs[index];
                if (backtrack(jobs, index + 1, workers, maxTime)) {
                    return true;
                }
                workers[i] -= jobs[index];
            }
            if (workers[i] == 0) break;
        }
        return false;
    }
};