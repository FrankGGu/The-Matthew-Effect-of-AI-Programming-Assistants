public class Solution {

import java.util.Arrays;

public class Solution {
    public int findMaxK(int[] nums) {
        Arrays.sort(nums);
        for (int i = nums.length - 1; i >= 0; i--) {
            if (nums[i] > 0 && Arrays.binarySearch(nums, -nums[i]) >= 0) {
                return nums[i];
            }
        }
        return -1;
    }
}
}