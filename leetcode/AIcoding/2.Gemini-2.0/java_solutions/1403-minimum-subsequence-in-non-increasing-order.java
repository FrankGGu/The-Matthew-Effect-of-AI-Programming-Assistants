import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> minSubsequence(int[] nums) {
        Arrays.sort(nums);
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }
        List<Integer> result = new ArrayList<>();
        int currentSum = 0;
        for (int i = nums.length - 1; i >= 0; i--) {
            result.add(nums[i]);
            currentSum += nums[i];
            totalSum -= nums[i];
            if (currentSum > totalSum) {
                break;
            }
        }
        return result;
    }
}