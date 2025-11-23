public class Solution {

import java.util.*;

public class Solution {
    public boolean isPossible(int[] nums, int k) {
        int n = nums.length;
        int[] diff = new int[n + 1];

        for (int i = 0; i < n; i++) {
            if (i > 0) {
                diff[i] += diff[i - 1];
            }
            int add = diff[i];
            if (nums[i] + add < k) {
                return false;
            }
            int need = (nums[i] + add) / k * k - (nums[i] + add);
            if (need > 0) {
                if (i + 1 < n) {
                    diff[i + 1] += need;
                }
                if (i + k < n) {
                    diff[i + k] -= need;
                }
            }
        }
        return true;
    }
}
}