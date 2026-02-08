public class Solution {

import java.util.*;

public class Solution {
    public int minimumReplacement(int[] nums) {
        int n = nums.length;
        int res = 0;
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] <= nums[i + 1]) {
                continue;
            }
            int k = nums[i] / nums[i + 1];
            if (nums[i] % nums[i + 1] != 0) {
                k++;
            }
            res += k - 1;
            int avg = nums[i] / k;
            if (nums[i] % k != 0) {
                avg++;
            }
            nums[i] = avg;
        }
        return res;
    }
}
}