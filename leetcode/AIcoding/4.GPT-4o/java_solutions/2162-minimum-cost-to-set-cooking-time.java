class Solution {
    public int minCostSetTime(int desired, int maxTime) {
        int minCost = Integer.MAX_VALUE;
        for (int h = 0; h <= 99; h++) {
            for (int m = 0; m < 60; m++) {
                int totalMinutes = h * 60 + m;
                if (totalMinutes > maxTime) continue;
                int cost = Math.abs(desired - totalMinutes);
                minCost = Math.min(minCost, cost);
            }
        }
        return minCost;
    }
}