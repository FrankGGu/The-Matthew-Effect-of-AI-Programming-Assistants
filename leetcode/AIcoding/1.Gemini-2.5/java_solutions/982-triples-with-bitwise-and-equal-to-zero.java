class Solution {
    public int triplesWithBitwiseANDEqualToZero(int[] nums) {
        int n = nums.length;
        int maxVal = (1 << 16); // Maximum possible value for nums[i] is 2^16 - 1.
                               // So, the result of (nums[i] & nums[j]) will also be less than 2^16.

        int[] countAnd = new int[maxVal];

        // Step 1: Calculate counts for all possible (nums[i] & nums[j]) pairs.
        // This takes O(N^2) time.
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                countAnd[nums[i] & nums[j]]++;
            }
        }

        // Step 2: Iterate through nums[k] and find matching (nums[i] & nums[j]) results.
        // This takes O(N * maxVal) time.
        int totalTriples = 0;
        for (int k = 0; k < n; k++) {
            for (int val = 0; val < maxVal; val++) {
                // If (val & nums[k]) == 0, then all countAnd[val] pairs (i, j)
                // can form a triple with nums[k] such that (nums[i] & nums[j] & nums[k]) == 0.
                if ((val & nums[k]) == 0) {
                    totalTriples += countAnd[val];
                }
            }
        }

        return totalTriples;
    }
}