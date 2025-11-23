public class Solution {

import java.util.*;

public class Solution {
    public long countWays(List<Integer> nums) {
        Collections.sort(nums);
        int n = nums.size();
        long ans = 1;
        for (int i = 1; i < n; i++) {
            if (nums.get(i) == nums.get(i - 1)) {
                continue;
            }
            ans *= (nums.get(i) - nums.get(i - 1));
        }
        return ans;
    }
}
}