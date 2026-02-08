public class Solution {
    public int[] evenOddBit(int[] nums) {
        int even = 0;
        int odd = 0;
        for (int i = 0; i < nums.length; i++) {
            if ((nums[i] & (1 << 0)) != 0) {
                odd++;
            }
            if ((nums[i] & (1 << 1)) != 0) {
                even++;
            }
        }
        return new int[]{even, odd};
    }
}