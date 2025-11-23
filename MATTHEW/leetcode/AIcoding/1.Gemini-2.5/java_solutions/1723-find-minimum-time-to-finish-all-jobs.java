import java.util.Arrays;

class Solution {
    int[] jobs;
    int k;
    int minMaxTime;
    int[] workerLoads;

    public int minimumTimeRequired(int[] jobs, int k) {
        this.jobs = jobs;
        this.k = k;
        this.minMaxTime = Integer.MAX_VALUE;
        this.workerLoads = new int[k];

        Arrays.sort(this.jobs);
        for (int i = 0; i < this.jobs.length / 2; i++) {
            int temp = this.jobs[i];
            this.jobs[i] = this.jobs[this.jobs.length - 1 - i];
            this.jobs[this.jobs.length - 1 - i] = temp;
        }

        dfs(0, 0);
        return minMaxTime;
    }

    private void dfs(int jobIndex, int currentMaxLoad) {
        if (currentMaxLoad >= minMaxTime) {
            return;
        }

        if (jobIndex == jobs.length) {
            minMaxTime = currentMaxLoad;
            return;
        }

        for (int i = 0; i < k; i++) {
            workerLoads[i] += jobs[jobIndex];
            dfs(jobIndex + 1, Math.max(currentMaxLoad, workerLoads[i]));
            workerLoads[i] -= jobs[jobIndex];

            if (workerLoads[i] == 0) {
                break;
            }
        }
    }
}