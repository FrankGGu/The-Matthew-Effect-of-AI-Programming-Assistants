import java.util.Arrays;

class Solution {
    public long maximizeHappiness(int[] happiness, int k) {
        Arrays.sort(happiness);
        long totalHappiness = 0;
        int n = happiness.length;

        for (int i = 0; i < k; i++) {
            int currentHappiness = happiness[n - 1 - i];
            long effectiveHappiness = Math.max(0, (long)currentHappiness - i);
            totalHappiness += effectiveHappiness;
        }

        return totalHappiness;
    }
}