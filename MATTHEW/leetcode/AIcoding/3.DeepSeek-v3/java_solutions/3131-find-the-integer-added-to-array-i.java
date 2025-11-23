class Solution {
    public int addedInteger(int[] nums1, int[] nums2) {
        int min1 = Integer.MAX_VALUE;
        int min2 = Integer.MAX_VALUE;

        for (int num : nums1) {
            if (num < min1) {
                min1 = num;
            }
        }

        for (int num : nums2) {
            if (num < min2) {
                min2 = num;
            }
        }

        return min2 - min1;
    }
}