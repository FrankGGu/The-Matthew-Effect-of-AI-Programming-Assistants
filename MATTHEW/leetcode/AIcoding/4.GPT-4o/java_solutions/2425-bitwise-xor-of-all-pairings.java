class Solution {
    public int xorAllNums(int[] nums1, int[] nums2) {
        int xor1 = 0, xor2 = 0;
        for (int num : nums1) xor1 ^= num;
        for (int num : nums2) xor2 ^= num;

        if ((nums1.length & 1) == 0 && (nums2.length & 1) == 0) return 0;
        if ((nums1.length & 1) == 0) return xor2;
        if ((nums2.length & 1) == 0) return xor1;

        return xor1 ^ xor2;
    }
}