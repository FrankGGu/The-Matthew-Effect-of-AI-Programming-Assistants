import java.util.Arrays;

class Solution {
    public int lengthOfLIS(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        int[] tails = new int[nums.length];
        int len = 0;

        for (int num : nums) {
            int i = Arrays.binarySearch(tails, 0, len, num);

            if (i < 0) {
                i = -(i + 1);
            }

            tails[i] = num;

            if (i == len) {
                len++;
            }
        }

        return len;
    }
}