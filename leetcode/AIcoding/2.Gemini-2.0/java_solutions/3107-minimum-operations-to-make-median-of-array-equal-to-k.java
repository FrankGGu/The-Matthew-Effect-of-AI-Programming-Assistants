import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        int less = 0, equal = 0, greater = 0;
        for (int num : nums) {
            if (num < k) {
                less++;
            } else if (num == k) {
                equal++;
            } else {
                greater++;
            }
        }

        if (equal == 0) {
            return -1;
        }

        int target = (n + 1) / 2;
        if (less >= target) {
            return less - (n - less);
        }

        int diff = target - (equal + less);
        return diff;
    }
}