import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> maxScoreIndices(int[] nums) {
        int n = nums.length;
        int[] leftZeros = new int[n + 1];
        int[] rightOnes = new int[n + 1];

        for (int i = 0; i < n; i++) {
            leftZeros[i + 1] = leftZeros[i] + (nums[i] == 0 ? 1 : 0);
        }

        for (int i = n - 1; i >= 0; i--) {
            rightOnes[i] = rightOnes[i + 1] + (nums[i] == 1 ? 1 : 0);
        }

        int maxScore = 0;
        for (int i = 0; i <= n; i++) {
            maxScore = Math.max(maxScore, leftZeros[i] + rightOnes[i]);
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            if (leftZeros[i] + rightOnes[i] == maxScore) {
                result.add(i);
            }
        }

        return result;
    }
}