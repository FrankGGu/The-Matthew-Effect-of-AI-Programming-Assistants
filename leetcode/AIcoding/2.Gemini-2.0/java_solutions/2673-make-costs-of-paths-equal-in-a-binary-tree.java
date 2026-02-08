class Solution {
    public int minIncrements(int n, int[] cost) {
        int ans = 0;
        for (int i = n / 2; i >= 1; i--) {
            ans += Math.abs(cost[2 * i - 1] - cost[2 * i]);
            cost[i - 1] += Math.max(cost[2 * i - 1], cost[2 * i]);
        }
        return ans;
    }
}