class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int n = nums1.length;

        // Helper function to calculate minimum swaps for a given set of target last elements
        // target1 is the value nums1[n-1] should be less than or equal to
        // target2 is the value nums2[n-1] should be less than or equal to
        // Returns Integer.MAX_VALUE if impossible, otherwise the number of swaps
        int res1 = calculateSwaps(nums1, nums2, nums1[n - 1], nums2[n - 1]);

        // Consider the case where nums1[n-1] and nums2[n-1] are swapped
        // This costs 1 operation for swapping the last elements themselves
        int res2 = calculateSwaps(nums1, nums2, nums2[n - 1], nums1[n - 1]);
        if (res2 != Integer.MAX_VALUE) {
            res2++; // Add 1 for the swap of the last elements
        }

        int minOps = Math.min(res1, res2);

        if (minOps == Integer.MAX_VALUE) {
            return -1;
        } else {
            return minOps;
        }
    }

    private int calculateSwaps(int[] nums1, int[] nums2, int target1, int target2) {
        int n = nums1.length;
        int swaps = 0;

        for (int i = 0; i < n - 1; i++) {
            boolean currentConfigOk = (nums1[i] <= target1 && nums2[i] <= target2);
            boolean swappedConfigOk = (nums2[i] <= target1 && nums1[i] <= target2);

            if (currentConfigOk) {
                // No swap needed for this index
                continue;
            } else if (swappedConfigOk) {
                // Swap needed for this index
                swaps++;
            } else {
                // Neither current configuration nor swapped configuration works
                return Integer.MAX_VALUE; // Indicate impossibility
            }
        }
        return swaps;
    }
}