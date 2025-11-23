class Solution {
    public boolean canBeRemoved(String colors, int[] neededTime) {
        int totalTime = 0, maxTime = 0;

        for (int i = 0; i < colors.length(); i++) {
            if (i > 0 && colors.charAt(i) == colors.charAt(i - 1)) {
                totalTime += Math.min(maxTime, neededTime[i]);
            } else {
                totalTime = 0;
            }
            maxTime = Math.max(maxTime, neededTime[i]);
        }

        return totalTime == 0;
    }
}