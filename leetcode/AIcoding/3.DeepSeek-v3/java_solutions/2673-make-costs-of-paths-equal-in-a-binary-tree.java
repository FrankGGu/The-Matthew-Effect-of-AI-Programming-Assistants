class Solution {
    public int minIncrements(int n, int[] cost) {
        int res = 0;
        for (int i = n / 2 - 1; i >= 0; i--) {
            int left = 2 * i + 1;
            int right = 2 * i + 2;
            res += Math.abs(cost[left] - cost[right]);
            cost[i] += Math.max(cost[left], cost[right]);
        }
        return res;
    }
}