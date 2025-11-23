class Solution {
    public int xorSum(int[] nums1, int[] nums2) {
        int xorSum1 = 0;
        for (int num : nums1) {
            xorSum1 ^= num;
        }

        int xorSum2 = 0;
        for (int num : nums2) {
            xorSum2 ^= num;
        }

        return xorSum1 & xorSum2;
    }
}