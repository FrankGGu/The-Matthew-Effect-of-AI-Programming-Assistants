public class Solution {

import java.util.Arrays;

public class Solution {
    public int deleteAndEarn(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }

        int[] count = new int[maxNum + 1];
        for (int num : nums) {
            count[num]++;
        }

        int prev = 0, curr = 0;
        for (int i = 1; i <= maxNum; i++) {
            int temp = curr;
            curr = Math.max(curr, prev + count[i] * i);
            prev = temp;
        }

        return curr;
    }
}
}