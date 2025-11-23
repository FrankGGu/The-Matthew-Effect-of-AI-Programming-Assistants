class Solution {
public:
    int minimumTimeRequired(vector<int>& jobs, int k) {
        int n = jobs.size();
        vector<int> workers(k, 0);
        int left = *max_element(jobs.begin(), jobs.end()), right = accumulate(jobs.begin(), jobs.end(), 0);

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canFinish(jobs, workers, mid, 0)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    bool canFinish(vector<int>& jobs, vector<int>& workers, int limit, int jobIndex) {
        if (jobIndex == jobs.size()) return true;
        for (int i = 0; i < workers.size(); i++) {
            if (workers[i] + jobs[jobIndex] <= limit) {
                workers[i] += jobs[jobIndex];
                if (canFinish(jobs, workers, limit, jobIndex + 1)) return true;
                workers[i] -= jobs[jobIndex];
            }
            if (workers[i] == 0) break;
        }
        return false;
    }
};