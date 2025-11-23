public class Solution {
    public int xorSum(int[] nums1, int[] nums2) {
        int result = 0;
        for (int num1 : nums1) {
            for (int num2 : nums2) {
                result ^= (num1 & num2);
            }
        }
        return result;
    }
}