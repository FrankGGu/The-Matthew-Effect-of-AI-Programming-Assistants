import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPermutation = new ArrayList<>();
        for (int num : nums) {
            currentPermutation.add(num);
        }
        backtrack(nums.length, currentPermutation, result, 0);
        return result;
    }

    private void backtrack(int n, List<Integer> currentPermutation, List<List<Integer>> result, int first) {
        if (first == n) {
            result.add(new ArrayList<>(currentPermutation));
            return;
        }

        for (int i = first; i < n; i++) {
            Collections.swap(currentPermutation, first, i);
            backtrack(n, currentPermutation, result, first + 1);
            Collections.swap(currentPermutation, first, i);
        }
    }
}