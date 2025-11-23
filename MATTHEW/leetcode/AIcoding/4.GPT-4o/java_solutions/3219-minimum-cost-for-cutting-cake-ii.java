import java.util.Arrays;

public class Solution {
    public int minCost(int[] cost) {
        int n = cost.length;
        if (n == 0) return 0;
        Arrays.sort(cost);
        int totalCost = 0;
        for (int i = 0; i < n; i++) {
            totalCost += cost[i] * (i + 1);
        }
        return totalCost;
    }
}