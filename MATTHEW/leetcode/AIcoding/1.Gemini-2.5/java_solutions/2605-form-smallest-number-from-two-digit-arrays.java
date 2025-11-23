import java.util.Arrays;

class Solution {
    public int minNumber(int[] nums1, int[] nums2) {
        Arrays.sort(nums1);
        Arrays.sort(nums2);

        // First, check for any common digit. The smallest common digit is the answer if it exists.
        for (int n1 : nums1) {
            for (int n2 : nums2) {
                if (n1 == n2) {
                    return n1; // Found the smallest common digit, return it
                }
            }
        }

        // If no common digit is found, we must form a two-digit number.
        // This number will be formed by the smallest digit from nums1 and the smallest digit from nums2.
        // To make the smallest two-digit number, the smaller of the two digits goes in the tens place.
        int min1 = nums1[0];
        int min2 = nums2[0];

        return Math.min(min1, min2) * 10 + Math.max(min1, min2);
    }
}