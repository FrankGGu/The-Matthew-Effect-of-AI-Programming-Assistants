import java.util.Arrays;

class Solution {
    public int minimumAddedInteger(int[] nums1, int[] nums2) {
        Arrays.sort(nums1);
        Arrays.sort(nums2);

        int n = nums1.length;
        int m = nums2.length; // nums2.length is always n - 2

        int minX = Integer.MAX_VALUE;

        // Iterate through all possible pairs of elements to remove from nums1
        // i and j are the indices of elements to be removed from nums1_sorted
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int p1 = 0; // Pointer for nums1 (effectively, for the subset of nums1 after removals)
                int p2 = 0; // Pointer for nums2
                int currentX = -1; // Candidate x for this specific pair of removed elements
                boolean isValid = true;

                // Match elements from the remaining nums1 with nums2
                while (p2 < m) {
                    // Skip the elements at indices i and j in nums1_sorted
                    while (p1 == i || p1 == j) {
                        p1++;
                    }

                    // This check is technically not strictly necessary given m = n-2,
                    // but provides robustness against unexpected array sizes.
                    if (p1 >= n) { 
                        isValid = false;
                        break;
                    }

                    if (currentX == -1) {
                        // This is the first pair of elements we are comparing.
                        // Determine the candidate x based on nums2[0] and the first available element from nums1.
                        currentX = nums2[p2] - nums1[p1];
                        if (currentX < 0) {
                            // x must be non-negative
                            isValid = false;
                            break;
                        }
                    } else {
                        // For subsequent pairs, verify that the difference is consistent with currentX.
                        if (nums2[p2] - nums1[p1] != currentX) {
                            isValid = false;
                            break;
                        }
                    }

                    p1++; // Move to the next element in nums1_sorted (or its conceptual subset)
                    p2++; // Move to the next element in nums2
                }

                if (isValid) {
                    minX = Math.min(minX, currentX);
                }
            }
        }

        return minX;
    }
}