public class Solution {

import java.util.*;

public class Solution {
    public int minMovesToMakeZigzag(int[] nums) {
        int n = nums.length;
        if (n <= 2) return 0;

        int even = 0, odd = 0;

        for (int i = 0; i < n - 1; i += 2) {
            if (i + 1 < n && nums[i] <= nums[i + 1]) {
                even += nums[i + 1] - nums[i] + 1;
                nums[i + 1] = nums[i] - 1;
            }
            if (i + 2 < n && nums[i] <= nums[i + 2]) {
                even += nums[i + 2] - nums[i] + 1;
                nums[i + 2] = nums[i] - 1;
            }
        }

        for (int i = 1; i < n - 1; i += 2) {
            if (i + 1 < n && nums[i] <= nums[i + 1]) {
                odd += nums[i + 1] - nums[i] + 1;
                nums[i + 1] = nums[i] - 1;
            }
            if (i + 2 < n && nums[i] <= nums[i + 2]) {
                odd += nums[i + 2] - nums[i] + 1;
                nums[i + 2] = nums[i] - 1;
            }
        }

        return Math.min(even, odd);
    }
}
}