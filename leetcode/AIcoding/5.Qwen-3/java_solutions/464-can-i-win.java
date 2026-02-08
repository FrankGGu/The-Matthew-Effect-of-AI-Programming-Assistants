public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean canIWin(int[] nums, int target) {
        if (target == 0) return true;
        if (nums.length == 0) return false;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum < target) return false;
        Map<Integer, Boolean> memo = new HashMap<>();
        return canIWin(nums, target, 0, 0, memo);
    }

    private boolean canIWin(int[] nums, int target, int used, int currentSum, Map<Integer, Boolean> memo) {
        if (memo.containsKey(used)) {
            return memo.get(used);
        }
        for (int i = 0; i < nums.length; i++) {
            if ((used & (1 << i)) == 0) {
                if (currentSum + nums[i] >= target) {
                    memo.put(used, true);
                    return true;
                }
                if (!canIWin(nums, target, used | (1 << i), currentSum + nums[i], memo)) {
                    memo.put(used, true);
                    return true;
                }
            }
        }
        memo.put(used, false);
        return false;
    }
}
}