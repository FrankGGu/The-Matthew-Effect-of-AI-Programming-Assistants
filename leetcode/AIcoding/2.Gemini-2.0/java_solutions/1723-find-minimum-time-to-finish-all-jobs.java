class Solution {
    public int minimumTimeRequired(int[] jobs, int k) {
        int n = jobs.length;
        int left = 0, right = 0;
        for (int job : jobs) {
            right += job;
        }
        int ans = right;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(jobs, k, mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }

    private boolean check(int[] jobs, int k, int limit) {
        int[] workers = new int[k];
        return backtrack(jobs, workers, 0, limit);
    }

    private boolean backtrack(int[] jobs, int[] workers, int jobIndex, int limit) {
        if (jobIndex == jobs.length) {
            return true;
        }

        for (int i = 0; i < workers.length; i++) {
            if (workers[i] + jobs[jobIndex] <= limit) {
                workers[i] += jobs[jobIndex];
                if (backtrack(jobs, workers, jobIndex + 1, limit)) {
                    return true;
                }
                workers[i] -= jobs[jobIndex];
            }
            if (workers[i] == 0) {
                break;
            }
        }
        return false;
    }
}