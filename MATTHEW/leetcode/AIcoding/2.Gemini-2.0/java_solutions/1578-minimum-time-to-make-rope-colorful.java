class Solution {
    public int minCost(String colors, int[] neededTime) {
        int cost = 0;
        int n = colors.length();
        int i = 0;
        while (i < n - 1) {
            if (colors.charAt(i) == colors.charAt(i + 1)) {
                int j = i;
                int maxTime = 0;
                int totalTime = 0;
                while (j < n && colors.charAt(i) == colors.charAt(j)) {
                    maxTime = Math.max(maxTime, neededTime[j]);
                    totalTime += neededTime[j];
                    j++;
                }
                cost += totalTime - maxTime;
                i = j;
            } else {
                i++;
            }
        }
        return cost;
    }
}