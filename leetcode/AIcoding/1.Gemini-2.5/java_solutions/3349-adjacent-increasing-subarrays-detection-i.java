class Solution {
    public boolean canBeSplit(int[] nums) {
        int n = nums.length;

        if (n < 2) {
            return false;
        }

        boolean[] prefixIncreasing = new boolean[n];
        boolean[] suffixIncreasing = new boolean[n];

        // Calculate if subarrays from the beginning are strictly increasing
        // prefixIncreasing[i] is true if nums[0...i] is strictly increasing
        prefixIncreasing[0] = true;
        for (int i = 1; i < n; i++) {
            prefixIncreasing[i] = prefixIncreasing[i - 1] && (nums[i] > nums[i - 1]);
        }

        // Calculate if subarrays to the end are strictly increasing
        // suffixIncreasing[i] is true if nums[i...n-1] is strictly increasing
        suffixIncreasing[n - 1] = true;
        for (int i = n - 2; i >= 0; i--) {
            suffixIncreasing[i] = suffixIncreasing[i + 1] && (nums[i] < nums[i + 1]);
        }

        // Iterate through all possible split points
        // A split point 'i' means the array is divided into nums[0...i] and nums[i+1...n-1]
        // Both subarrays must be non-empty, so 'i' can range from 0 to n-2.
        for (int i = 0; i < n - 1; i++) {
            if (prefixIncreasing[i] && suffixIncreasing[i + 1]) {
                return true;
            }
        }

        return false;
    }
}