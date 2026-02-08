class Solution {
    public int xorAllNums(int[] nums1, int[] nums2) {
        int xorSum1 = 0;
        for (int num : nums1) {
            xorSum1 ^= num;
        }

        int xorSum2 = 0;
        for (int num : nums2) {
            xorSum2 ^= num;
        }

        int result = 0;

        if (nums2.length % 2 == 1) {
            result ^= xorSum1;
        }

        if (nums1.length % 2 == 1) {
            result ^= xorSum2;
        }

        return result;
    }
}