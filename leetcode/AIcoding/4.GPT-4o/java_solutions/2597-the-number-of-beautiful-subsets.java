import java.util.HashSet;

public class Solution {
    public int beautifulSubsets(int[] nums, int k) {
        HashSet<Integer> set = new HashSet<>();
        return dfs(nums, 0, set, k);
    }

    private int dfs(int[] nums, int index, HashSet<Integer> set, int k) {
        if (index == nums.length) {
            return 1;
        }
        int count = 0;
        count += dfs(nums, index + 1, set, k);
        if (!set.contains(nums[index] - k) && !set.contains(nums[index] + k)) {
            set.add(nums[index]);
            count += dfs(nums, index + 1, set, k);
            set.remove(nums[index]);
        }
        return count;
    }
}