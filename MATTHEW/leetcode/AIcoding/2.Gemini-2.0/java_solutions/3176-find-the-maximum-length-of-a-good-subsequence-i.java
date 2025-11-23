import java.util.Arrays;

class Solution {
    public int findTheLongestBalancedSubsequence(int[] nums) {
        int count0 = 0;
        int count1 = 0;
        for (int num : nums) {
            if (num == 0) {
                count0++;
            }
        }
        for (int num : nums) {
            if (num == 1) {
                count1++;
            }
        }
        return 2 * Math.min(count0, count1);
    }
}