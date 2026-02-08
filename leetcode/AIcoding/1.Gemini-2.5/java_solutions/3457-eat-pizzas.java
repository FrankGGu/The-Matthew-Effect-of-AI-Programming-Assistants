import java.util.Arrays;

class Solution {
    public int maxSatisfaction(int[] satisfaction) {
        Arrays.sort(satisfaction);

        int maxTotalSatisfaction = 0;
        int currentPrefixSum = 0;
        int currentTotalSatisfaction = 0;

        for (int i = satisfaction.length - 1; i >= 0; i--) {
            int s = satisfaction[i];

            if (currentPrefixSum + s > 0) {
                currentPrefixSum += s;
                currentTotalSatisfaction += currentPrefixSum;
                maxTotalSatisfaction = Math.max(maxTotalSatisfaction, currentTotalSatisfaction);
            } else {
                break;
            }
        }

        return maxTotalSatisfaction;
    }
}