import java.util.Arrays;

class Solution {
    public int minimizeMax(int[] nums, int p) {
        Arrays.sort(nums);
        int n = nums.length;

        int left = 0; // Minimum possible maximum difference (0)
        int right = nums[n - 1] - nums[0]; // Maximum possible maximum difference

        int ans = right; // Initialize answer with the largest possible difference

        while (left <= right) {
            int mid = left + (right - left) / 2; // Current maximum difference to check

            if (canFormPairs(mid, nums, p)) {
                ans = mid; // It's possible to achieve this difference, try for a smaller one
                right = mid - 1;
            } else {
                left = mid + 1; // Not possible, need a larger difference
            }
        }
        return ans;
    }

    // Helper function to check if it's possible to form 'p' pairs
    // such that the difference of each pair is at most 'maxDiff'.
    private boolean canFormPairs(int maxDiff, int[] nums, int p) {
        int count = 0; // Number of pairs formed
        for (int i = 0; i < nums.length - 1; ) {
            if (nums[i+1] - nums[i] <= maxDiff) {
                count++;
                i += 2; // If a pair is formed, both elements are used, skip the next element
            } else {
                i += 1; // If no pair is formed, move to the next element
            }
            if (count >= p) {
                return true; // Optimization: if we already found enough pairs, no need to continue
            }
        }
        return count >= p;
    }
}