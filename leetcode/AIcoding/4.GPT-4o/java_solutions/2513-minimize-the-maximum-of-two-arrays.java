public class Solution {
    public int minimizeArrayValue(int[] nums) {
        long sum = 0;
        int max = 0;
        for (int num : nums) {
            sum += num;
            max = Math.max(max, num);
        }
        int left = max, right = (int)(sum / nums.length + (sum % nums.length == 0 ? 0 : 1));
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canAchieve(nums, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canAchieve(int[] nums, int target) {
        long surplus = 0;
        for (int num : nums) {
            if (num > target) {
                surplus += num - target;
            } else {
                surplus -= Math.min(target - num, surplus);
            }
            if (surplus < 0) return false;
        }
        return true;
    }
}