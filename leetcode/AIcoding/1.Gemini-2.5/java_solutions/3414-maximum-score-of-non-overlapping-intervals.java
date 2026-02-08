import java.util.Arrays;
import java.util.Comparator;
import java.util.TreeMap;

class Solution {
    public int jobScheduling(int[] startTime, int[] endTime, int[] profit) {
        int n = startTime.length;
        int[][] jobs = new int[n][3];
        for (int i = 0; i < n; i++) {
            jobs[i][0] = startTime[i];
            jobs[i][1] = endTime[i];
            jobs[i][2] = profit[i];
        }

        Arrays.sort(jobs, Comparator.comparingInt(a -> a[1]));

        TreeMap<Integer, Integer> dp = new TreeMap<>();
        dp.put(0, 0); 

        for (int[] job : jobs) {
            int start = job[0];
            int end = job[1];
            int currentProfit = job[2];

            int profitBeforeStart = dp.floorEntry(start).getValue();

            int newTotalProfit = profitBeforeStart + currentProfit;

            int maxProfitSoFar = dp.lastEntry().getValue();

            if (newTotalProfit > maxProfitSoFar) {
                dp.put(end, newTotalProfit);
            }
        }

        return dp.lastEntry().getValue();
    }
}