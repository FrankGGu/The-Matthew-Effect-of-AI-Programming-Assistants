import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<List<Integer>> permuteUnique(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums == null || nums.length == 0) {
            return result;
        }
        Arrays.sort(nums);
        boolean[] used = new boolean[nums.length];
        List<Integer> currentPermutation = new ArrayList<>();
        backtrack(nums, used, currentPermutation, result);
        return result;
    }

    private void backtrack(int[] nums, boolean[] used, List<Integer> currentPermutation, List<List<Integer>> result) {
        if (currentPermutation.size() == nums.length) {
            result.add(new ArrayList<>(currentPermutation));
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) {
                continue;
            }

            used[i] = true;
            currentPermutation.add(nums[i]);
            backtrack(nums, used, currentPermutation, result);
            currentPermutation.remove(currentPermutation.size() - 1);
            used[i] = false;
        }
    }
}