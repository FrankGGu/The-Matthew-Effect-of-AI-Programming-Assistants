class Solution {
    public int maxSatisfaction(int[] satisfaction) {
        Arrays.sort(satisfaction);
        int n = satisfaction.length;
        int maxSum = 0;
        int currentSum = 0;
        int total = 0;

        for (int i = n - 1; i >= 0; i--) {
            currentSum += satisfaction[i];
            total += currentSum;
            if (total > maxSum) {
                maxSum = total;
            } else if (currentSum < 0) {
                break;
            }
        }

        return maxSum;
    }
}