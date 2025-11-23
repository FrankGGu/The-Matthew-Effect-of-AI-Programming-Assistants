public class Solution {

import java.util.*;

public class Solution {
    public int sumImbalanceNumbers(int[] nums) {
        int n = nums.length;
        int result = 0;
        for (int i = 0; i < n; i++) {
            TreeSet<Integer> set = new TreeSet<>();
            set.add(nums[i]);
            int imbalance = 0;
            for (int j = i + 1; j < n; j++) {
                Integer floor = set.floor(nums[j]);
                Integer ceiling = set.ceiling(nums[j]);
                if (floor == null && ceiling == null) {
                    imbalance += 1;
                } else if (floor == null) {
                    imbalance += nums[j] - ceiling;
                } else if (ceiling == null) {
                    imbalance += floor - nums[j];
                } else {
                    imbalance += Math.min(ceiling - nums[j], nums[j] - floor);
                }
                result += imbalance;
                set.add(nums[j]);
            }
        }
        return result;
    }
}
}