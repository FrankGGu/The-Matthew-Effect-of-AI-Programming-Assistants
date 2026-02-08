class Solution {
    public int minimumCost(int[] cost) {
        Arrays.sort(cost);
        int totalCost = 0;
        for (int i = cost.length - 1; i >= 0; i--) {
            totalCost += cost[i];
            if ((cost.length - 1 - i) % 3 == 2) {
                totalCost -= cost[i];
            }
        }
        return totalCost;
    }
}