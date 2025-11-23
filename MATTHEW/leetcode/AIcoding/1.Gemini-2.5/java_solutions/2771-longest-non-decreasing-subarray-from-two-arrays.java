class Solution {
    public int longestNondecreasingSubarray(int[] nums1, int[] nums2) {
        int n = nums1.length;

        int prevDp1 = 1; // Longest non-decreasing subarray ending at i-1 using nums1[i-1]
        int prevDp2 = 1; // Longest non-decreasing subarray ending at i-1 using nums2[i-1]

        int maxLength = 1;

        for (int i = 1; i < n; i++) {
            int currentDp1 = 1; // Longest non-decreasing subarray ending at i using nums1[i]
            int currentDp2 = 1; // Longest non-decreasing subarray ending at i using nums2[i]

            // Calculate currentDp1 (if we choose nums1[i])
            if (nums1[i] >= nums1[i-1]) {
                currentDp1 = Math.max(currentDp1, prevDp1 + 1);
            }
            if (nums1[i] >= nums2[i-1]) {
                currentDp1 = Math.max(currentDp1, prevDp2 + 1);
            }

            // Calculate currentDp2 (if we choose nums2[i])
            if (nums2[i] >= nums1[i-1]) {
                currentDp2 = Math.max(currentDp2, prevDp1 + 1);
            }
            if (nums2[i] >= nums2[i-1]) {
                currentDp2 = Math.max(currentDp2, prevDp2 + 1);
            }

            // Update prev values for the next iteration
            prevDp1 = currentDp1;
            prevDp2 = currentDp2;

            // Update overall maximum length
            maxLength = Math.max(maxLength, Math.max(currentDp1, currentDp2));
        }

        return maxLength;
    }
}