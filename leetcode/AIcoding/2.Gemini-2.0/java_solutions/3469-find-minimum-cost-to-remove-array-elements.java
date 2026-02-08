import java.util.Arrays;

class Solution {
    public long findMinimumCost(int[] cost) {
        Arrays.sort(cost);
        long ans = 0;
        int n = cost.length;
        for (int i = 0; i < n / 3; i++) {
            cost[i] = 0;
        }
        for (int i = 0; i < n; i++) {
            ans += cost[i];
        }
        return ans;
    }
}