public class Solution {

import java.util.Arrays;

public class Solution {
    public int numSubseqsThatSatisfyTheGivenSumCondition(int[] nums, int target) {
        int MOD = 1000000007;
        Arrays.sort(nums);
        int n = nums.length;
        int count = 0;
        int left = 0, right = n - 1;
        while (left <= right) {
            if (nums[left] + nums[right] <= target) {
                count = (count + (1 << (right - left))) % MOD;
                left++;
            } else {
                right--;
            }
        }
        return count;
    }
}
}