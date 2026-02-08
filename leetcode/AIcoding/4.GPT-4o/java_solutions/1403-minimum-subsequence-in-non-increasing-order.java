import java.util.*;

class Solution {
    public List<Integer> minSubsequence(int[] nums) {
        int totalSum = 0, subsequenceSum = 0;
        List<Integer> result = new ArrayList<>();

        for (int num : nums) {
            totalSum += num;
        }

        Arrays.sort(nums);

        for (int i = nums.length - 1; i >= 0; i--) {
            subsequenceSum += nums[i];
            result.add(nums[i]);
            if (subsequenceSum > totalSum - subsequenceSum) {
                break;
            }
        }

        return result;
    }
}