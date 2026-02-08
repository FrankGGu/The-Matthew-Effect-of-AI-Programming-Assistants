import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int maxProfitAssignment(int[] difficulty, int[] profit, int[] worker) {
        int n = difficulty.length;
        int m = worker.length;

        int[][] jobs = new int[n][2];
        for (int i = 0; i < n; i++) {
            jobs[i][0] = difficulty[i];
            jobs[i][1] = profit[i];
        }

        Arrays.sort(jobs, Comparator.comparingInt(a -> a[0]));
        Arrays.sort(worker);

        int totalProfit = 0;
        int maxProfitForCurrentAbility = 0;
        int jobPointer = 0;

        for (int wAbility : worker) {
            while (jobPointer < n && jobs[jobPointer][0] <= wAbility) {
                maxProfitForCurrentAbility = Math.max(maxProfitForCurrentAbility, jobs[jobPointer][1]);
                jobPointer++;
            }
            totalProfit += maxProfitForCurrentAbility;
        }

        return totalProfit;
    }
}