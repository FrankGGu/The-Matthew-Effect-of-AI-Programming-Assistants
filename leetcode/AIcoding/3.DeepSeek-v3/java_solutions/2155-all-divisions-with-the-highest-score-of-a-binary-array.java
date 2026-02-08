class Solution {
    public List<Integer> maxScoreIndices(int[] nums) {
        int n = nums.length;
        int[] leftZeros = new int[n + 1];
        int[] rightOnes = new int[n + 1];

        for (int i = 0; i <= n; i++) {
            if (i == 0) {
                leftZeros[i] = 0;
            } else {
                leftZeros[i] = leftZeros[i - 1] + (nums[i - 1] == 0 ? 1 : 0);
            }
        }

        for (int i = n; i >= 0; i--) {
            if (i == n) {
                rightOnes[i] = 0;
            } else {
                rightOnes[i] = rightOnes[i + 1] + (nums[i] == 1 ? 1 : 0);
            }
        }

        int maxScore = 0;
        List<Integer> result = new ArrayList<>();

        for (int i = 0; i <= n; i++) {
            int currentScore = leftZeros[i] + rightOnes[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                result.clear();
                result.add(i);
            } else if (currentScore == maxScore) {
                result.add(i);
            }
        }

        return result;
    }
}