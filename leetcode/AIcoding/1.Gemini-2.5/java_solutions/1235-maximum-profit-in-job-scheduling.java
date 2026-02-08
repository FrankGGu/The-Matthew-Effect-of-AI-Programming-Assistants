import java.util.Arrays;
import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public int jobScheduling(int[] startTime, int[] endTime, int[] profit) {
        int n = startTime.length;
        Job[] jobs = new Job[n];
        for (int i = 0; i < n; i++) {
            jobs[i] = new Job(startTime[i], endTime[i], profit[i]);
        }

        Arrays.sort(jobs, Comparator.comparingInt(j -> j.startTime));

        // TreeMap to store (endTime, maxProfitUpToEndTime)
        // The keys are end times, and values are the maximum profit achievable up to that end time.
        // The values in the TreeMap will be non-decreasing.
        TreeMap<Integer, Integer> dp = new TreeMap<>();
        dp.put(0, 0); // Base case: 0 profit at time 0.

        for (Job job : jobs) {
            // Find the maximum profit achievable just before the current job starts.
            // dp.floorEntry(job.startTime) finds the entry with the greatest key <= job.startTime.
            // Its value is the maximum profit from jobs that end at or before job.startTime.
            Map.Entry<Integer, Integer> floorEntry = dp.floorEntry(job.startTime);
            int profitBeforeCurrentJob = floorEntry.getValue();

            // Calculate the total profit if we take the current job.
            int currentTotalProfit = profitBeforeCurrentJob + job.profit;

            // Get the current maximum profit recorded in dp up to the latest time.
            // This is equivalent to the overall maximum profit found so far.
            int maxProfitOverall = dp.lastEntry().getValue();

            // If taking the current job results in a higher profit than the overall maximum profit achieved so far,
            // then we update the TreeMap.
            // The TreeMap ensures that for any time 't', dp.get(t) gives the maximum profit up to 't'.
            // We only add a new entry if it strictly increases the maximum profit.
            if (currentTotalProfit > maxProfitOverall) {
                dp.put(job.endTime, currentTotalProfit);

                // Remove redundant entries:
                // If there are entries (time_k, profit_k) such that time_k > job.endTime
                // and profit_k <= currentTotalProfit, they are now redundant.
                // This is because we have a higher or equal profit (currentTotalProfit) at an earlier time (job.endTime).
                Map.Entry<Integer, Integer> nextEntry = dp.higherEntry(job.endTime);
                while (nextEntry != null && nextEntry.getValue() <= currentTotalProfit) {
                    dp.remove(nextEntry.getKey());
                    nextEntry = dp.higherEntry(job.endTime);
                }
            }
        }

        return dp.lastEntry().getValue();
    }

    static class Job {
        int startTime;
        int endTime;
        int profit;

        public Job(int startTime, int endTime, int profit) {
            this.startTime = startTime;
            this.endTime = endTime;
            this.profit = profit;
        }
    }
}