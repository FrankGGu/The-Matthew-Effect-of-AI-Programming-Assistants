class Solution {
    public String minimumCost(String s, int[] cost) {
        int n = s.length();
        StringBuilder result = new StringBuilder();
        int totalCost = 0;
        int maxCost = 0;

        for (int i = 0; i < n; i++) {
            totalCost += cost[i];
            maxCost = Math.max(maxCost, cost[i]);
            if (i == n - 1 || s.charAt(i) != s.charAt(i + 1)) {
                result.append(s.charAt(i));
                totalCost -= maxCost;
                maxCost = 0;
            }
        }

        return result.toString();
    }
}