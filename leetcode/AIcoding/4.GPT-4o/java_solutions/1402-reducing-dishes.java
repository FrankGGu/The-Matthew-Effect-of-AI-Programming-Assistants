import java.util.Arrays;

class Solution {
    public int maxSatisfaction(int[] satisfaction) {
        Arrays.sort(satisfaction);
        int n = satisfaction.length;
        int maxSatisfaction = 0, total = 0, sum = 0;

        for (int i = n - 1; i >= 0; i--) {
            total += satisfaction[i];
            sum += total;
            maxSatisfaction = Math.max(maxSatisfaction, sum);
        }

        return maxSatisfaction;
    }
}