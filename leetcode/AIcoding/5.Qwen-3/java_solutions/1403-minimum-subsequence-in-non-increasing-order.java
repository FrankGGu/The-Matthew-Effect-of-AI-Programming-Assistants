public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> minSubsequence(int[] nums) {
        Arrays.sort(nums);
        List<Integer> result = new ArrayList<>();
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int currentSum = 0;
        for (int i = nums.length - 1; i >= 0; i--) {
            currentSum += nums[i];
            result.add(nums[i]);
            if (currentSum > sum - currentSum) {
                break;
            }
        }
        return result;
    }
}
}