public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(nums, 0, new ArrayList<>(), result);
        return result;
    }

    private void backtrack(int[] nums, int start, List<Integer> path, List<List<Integer>> result) {
        if (path.size() == nums.length) {
            result.add(new ArrayList<>(path));
            return;
        }
        for (int i = start; i < nums.length; i++) {
            Collections.swap(nums, i, start);
            path.add(nums[start]);
            backtrack(nums, start + 1, path, result);
            path.remove(path.size() - 1);
            Collections.swap(nums, i, start);
        }
    }
}
}