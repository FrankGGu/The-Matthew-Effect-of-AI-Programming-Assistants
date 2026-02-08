public class Solution {

import java.util.*;

public class Solution {
    public int earliestSecond(int[] nums) {
        int n = nums.length;
        int[] count = new int[n];
        Arrays.fill(count, 0);
        int[] last = new int[n];
        Arrays.fill(last, -1);
        int res = 0;
        for (int i = 0; i < n; i++) {
            if (last[nums[i]] != -1 && last[nums[i]] + 1 <= i) {
                count[nums[i]]++;
                if (count[nums[i]] == 1) {
                    res = Math.max(res, i - last[nums[i]]);
                }
            } else {
                count[nums[i]]++;
            }
            last[nums[i]] = i;
        }
        return res;
    }
}
}