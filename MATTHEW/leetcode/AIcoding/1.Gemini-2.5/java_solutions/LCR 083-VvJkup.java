import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPermutation = new ArrayList<>();
        boolean[] used = new boolean[nums.length];
        backtrack(nums, currentPermutation, used, result);
        return result;
    }

    private void backtrack(int[] nums, List<Integer> currentPermutation, boolean[] used, List<List<Integer>> result) {
        if (currentPermutation.size() == nums.length) {
            result.add(new ArrayList<>(currentPermutation));
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (!used[i]) {
                used[i] = true;
                currentPermutation.add(nums[i]);
                backtrack(nums, currentPermutation, used, result);
                currentPermutation.remove(currentPermutation.size() - 1);
                used[i] = false;
            }
        }
    }
}