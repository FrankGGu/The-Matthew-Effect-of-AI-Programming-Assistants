class Solution {
    public int minCost(String colors, int[] neededTime) {
        int totalTime = 0;
        int i = 0, j = 0;
        int n = colors.length();

        while (i < n && j < n) {
            int maxTime = 0;
            int sumTime = 0;
            while (j < n && colors.charAt(i) == colors.charAt(j)) {
                sumTime += neededTime[j];
                maxTime = Math.max(maxTime, neededTime[j]);
                j++;
            }
            totalTime += sumTime - maxTime;
            i = j;
        }

        return totalTime;
    }
}