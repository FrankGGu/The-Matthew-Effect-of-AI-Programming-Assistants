class Solution {
    public int minCost(String colors, int[] neededTime) {
        int n = colors.length();
        int totalCost = 0;
        int i = 0;

        while (i < n) {
            int j = i;
            int currentGroupSum = 0;
            int currentGroupMax = 0;

            // Find the end of the current group of same-colored balloons
            while (j < n && colors.charAt(j) == colors.charAt(i)) {
                currentGroupSum += neededTime[j];
                currentGroupMax = Math.max(currentGroupMax, neededTime[j]);
                j++;
            }

            // If there was more than one balloon in the group, we need to remove some
            // The cost for this group is (sum of times) - (max time to keep)
            if (j - i > 1) {
                totalCost += (currentGroupSum - currentGroupMax);
            }

            // Move to the start of the next potential group
            i = j;
        }

        return totalCost;
    }
}