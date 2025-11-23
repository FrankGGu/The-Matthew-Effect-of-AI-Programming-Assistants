class Solution {
    public int countAlmostEqualPairs(int[] nums1, int[] nums2, int diff) {
        int count = 0;
        for (int i = 0; i < nums1.length; i++) {
            for (int j = i + 1; j < nums1.length; j++) {
                int diff1 = Math.abs(nums1[i] - nums1[j]);
                int diff2 = Math.abs(nums2[i] - nums2[j]);
                if (diff1 <= diff && diff2 <= diff) {
                    count++;
                }
            }
        }
        return count;
    }
}