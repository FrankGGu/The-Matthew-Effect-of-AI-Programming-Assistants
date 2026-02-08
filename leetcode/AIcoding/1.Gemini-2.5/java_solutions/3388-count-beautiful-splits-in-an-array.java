class Solution {
    public int beautifulSplits(int[] nums, int k) {
        int n = nums.length;
        int[] prefixOnes = new int[n];

        // Calculate prefix sums of ones
        if (n > 0) {
            prefixOnes[0] = nums[0];
            for (int i = 1; i < n; i++) {
                prefixOnes[i] = prefixOnes[i - 1] + nums[i];
            }
        }

        int totalOnes = (n > 0) ? prefixOnes[n - 1] : 0;
        int count = 0;

        // Iterate through all possible split points 'i'
        // 'i' represents the last index of the first subarray (nums[0...i])
        // The second subarray is nums[i+1...n-1]
        // Both subarrays must be non-empty, so 'i' can range from 0 to n-2.
        for (int i = 0; i < n - 1; i++) {
            int leftOnes = prefixOnes[i];
            int rightOnes = totalOnes - leftOnes;

            // Check if both conditions for a beautiful split are met
            if (leftOnes == k && rightOnes == k) {
                count++;
            }
        }

        return count;
    }
}