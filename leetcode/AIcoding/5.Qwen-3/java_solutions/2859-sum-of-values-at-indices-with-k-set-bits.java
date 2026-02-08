public class Solution {
    public int sumIndicesWithKSetBits(int[] nums, int k) {
        int result = 0;
        for (int i = 0; i < nums.length; i++) {
            if (countSetBits(i) == k) {
                result += nums[i];
            }
        }
        return result;
    }

    private int countSetBits(int n) {
        int count = 0;
        while (n > 0) {
            count += n & 1;
            n >>= 1;
        }
        return count;
    }
}