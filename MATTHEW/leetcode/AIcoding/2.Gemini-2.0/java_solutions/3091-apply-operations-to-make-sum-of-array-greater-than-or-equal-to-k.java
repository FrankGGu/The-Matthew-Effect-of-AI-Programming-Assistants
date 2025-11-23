import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        Arrays.sort(nums);
        int operations = 0;
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        if (sum >= k) {
            return 0;
        }

        for (int i = 0; i < n; i++) {
            sum -= nums[i];
            sum += (long) Math.floor(nums[i] / 2.0);
            operations++;
            if (sum >= k) {
                break;
            }
        }

        return operations;
    }
}