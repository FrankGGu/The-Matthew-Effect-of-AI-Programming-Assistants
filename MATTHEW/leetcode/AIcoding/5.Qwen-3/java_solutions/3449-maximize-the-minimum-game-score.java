public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] maximizeTheMinimumGameScore(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int[] result = new int[n];
        int left = 0, right = n - 1;
        boolean isLeft = true;
        for (int i = 0; i < n; i++) {
            if (isLeft) {
                result[i] = nums[left++];
            } else {
                result[i] = nums[right--];
            }
            isLeft = !isLeft;
        }
        return result;
    }
}
}