public class Solution {
    public int rotateFunction(int[] nums) {
        int n = nums.length;
        int max = 0;
        for (int i = 0; i < n; i++) {
            max += i * nums[i];
        }
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int result = max;
        for (int i = 1; i < n; i++) {
            max = max + sum - n * nums[n - i];
            if (max > result) {
                result = max;
            }
        }
        return result;
    }
}