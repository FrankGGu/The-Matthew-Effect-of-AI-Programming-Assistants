import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPermutation = new ArrayList<>();
        boolean[] used = new boolean[nums.length];
        permuteHelper(nums, used, currentPermutation, result);
        return result;
    }

    private void permuteHelper(int[] nums, boolean[] used, List<Integer> currentPermutation, List<List<Integer>> result) {
        if (currentPermutation.size() == nums.length) {
            result.add(new ArrayList<>(currentPermutation));
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (!used[i]) {
                used[i] = true;
                currentPermutation.add(nums[i]);
                permuteHelper(nums, used, currentPermutation, result);
                currentPermutation.remove(currentPermutation.size() - 1);
                used[i] = false;
            }
        }
    }
}