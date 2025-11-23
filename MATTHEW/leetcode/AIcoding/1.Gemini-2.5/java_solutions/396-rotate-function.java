class Solution {
    public int maxRotateFunction(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        long totalSum = 0;
        long currentF = 0;

        // Calculate F(0) and the total sum of elements
        for (int i = 0; i < n; i++) {
            totalSum += nums[i];
            currentF += (long)i * nums[i];
        }

        long maxF = currentF;

        // Iterate to calculate F(1), F(2), ..., F(n-1)
        // Using the relation: F(k) = F(k-1) + totalSum - n * nums[n - k]
        // This formula relates F(k) to F(k-1) by considering the element nums[n-k]
        // which moves from the last position to the first (coefficient changes from n-1 to 0)
        // when rotating the array to the right by one position.
        for (int k = 1; k < n; k++) {
            currentF = currentF + totalSum - (long)n * nums[n - k];
            maxF = Math.max(maxF, currentF);
        }

        return (int)maxF;
    }
}