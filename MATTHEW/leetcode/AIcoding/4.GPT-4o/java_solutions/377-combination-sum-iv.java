import java.util.HashMap;

public class Solution {
    public int combinationSum4(int[] nums, int target) {
        HashMap<Integer, Integer> memo = new HashMap<>();
        return helper(nums, target, memo);
    }

    private int helper(int[] nums, int target, HashMap<Integer, Integer> memo) {
        if (target == 0) return 1;
        if (target < 0) return 0;
        if (memo.containsKey(target)) return memo.get(target);

        int count = 0;
        for (int num : nums) {
            count += helper(nums, target - num, memo);
        }

        memo.put(target, count);
        return count;
    }
}