import java.util.Arrays;

public class Solution {
    public int minimumTimeRequired(int[] jobs, int k) {
        int n = jobs.length;
        int[] workers = new int[k];
        Arrays.sort(jobs);
        return backtrack(jobs, workers, n - 1);
    }

    private int backtrack(int[] jobs, int[] workers, int index) {
        if (index < 0) {
            return Arrays.stream(workers).max().getAsInt();
        }
        int minTime = Integer.MAX_VALUE;
        for (int i = 0; i < workers.length; i++) {
            workers[i] += jobs[index];
            minTime = Math.min(minTime, backtrack(jobs, workers, index - 1));
            workers[i] -= jobs[index];
            if (workers[i] == 0) break; // optimization
        }
        return minTime;
    }
}