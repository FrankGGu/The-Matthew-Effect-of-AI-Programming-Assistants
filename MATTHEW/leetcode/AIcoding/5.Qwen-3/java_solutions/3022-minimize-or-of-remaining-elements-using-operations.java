public class Solution {

import java.util.*;

public class Solution {
    public int minimizeOrOfRemainingElements(int[] nums, int k) {
        int n = nums.length;
        Arrays.sort(nums);
        for (int i = 0; i < k; i++) {
            nums[i] = 0;
        }
        int result = 0;
        for (int num : nums) {
            result |= num;
        }
        return result;
    }
}
}