import java.util.Arrays;

class Solution {
    public int maxProfitAssignment(int[] difficulty, int[] profit, int[] worker) {
        int n = difficulty.length;
        int m = worker.length;
        int[][] jobs = new int[n][2];

        for (int i = 0; i < n; i++) {
            jobs[i][0] = difficulty[i];
            jobs[i][1] = profit[i];
        }

        Arrays.sort(jobs, (a, b) -> Integer.compare(a[0], b[0]));
        Arrays.sort(worker);

        int maxProfit = 0;
        int j = 0;
        int maxProfitSoFar = 0;

        for (int w : worker) {
            while (j < n && jobs[j][0] <= w) {
                maxProfitSoFar = Math.max(maxProfitSoFar, jobs[j][1]);
                j++;
            }
            maxProfit += maxProfitSoFar;
        }

        return maxProfit;
    }
}