import java.util.Arrays;

class Solution {
    public long maxSpending(int[][] costs) {
        int n = costs.length;
        int[] allCosts = new int[n * n];
        int k = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                allCosts[k++] = costs[i][j];
            }
        }

        Arrays.sort(allCosts);

        long totalSpending = 0;
        for (int i = 0; i < allCosts.length; i++) {
            totalSpending += (long) allCosts[i] * (i + 1);
        }

        return totalSpending;
    }
}