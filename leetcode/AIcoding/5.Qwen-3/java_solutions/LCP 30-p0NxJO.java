public class Solution {

import java.util.*;

public class Solution {
    public int magicTower(int[] nums) {
        int n = nums.length;
        long total = 0;
        for (int num : nums) {
            total += num;
        }
        if (total < 0) {
            return -1;
        }
        Arrays.sort(nums);
        int res = 0;
        long health = 1;
        for (int i = 0; i < n; i++) {
            health += nums[i];
            if (health <= 0) {
                res++;
                health -= nums[i];
            }
        }
        return res;
    }
}
}