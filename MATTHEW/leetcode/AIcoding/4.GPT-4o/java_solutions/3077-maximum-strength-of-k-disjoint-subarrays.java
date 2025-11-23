import java.util.Arrays;

public class Solution {
    public long maxStrength(int[] nums, int k) {
        int n = nums.length;
        Arrays.sort(nums);
        long maxStrength = 1;
        int count = 0;

        for (int i = n - 1; i >= 0 && count < k; i--) {
            if (nums[i] > 0) {
                maxStrength *= nums[i];
                count++;
            }
        }

        if (count < k) {
            for (int i = 0; i < n && count < k; i++) {
                if (nums[i] < 0) {
                    maxStrength *= nums[i];
                    count++;
                }
            }
        }

        if (count < k) {
            return 0;
        }

        return maxStrength;
    }
}