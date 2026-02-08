import java.util.Arrays;

public class Solution {
    public int kSum(int[] nums, int k) {
        Arrays.sort(nums);
        return kSumHelper(nums, k, 0, 0);
    }

    private int kSumHelper(int[] nums, int k, int start, int sum) {
        if (k == 0) return sum;
        if (start >= nums.length) return 0;

        int result = 0;
        for (int i = start; i < nums.length; i++) {
            if (i > start && nums[i] == nums[i - 1]) continue;
            result += kSumHelper(nums, k - 1, i + 1, sum + nums[i]);
        }
        return result;
    }
}