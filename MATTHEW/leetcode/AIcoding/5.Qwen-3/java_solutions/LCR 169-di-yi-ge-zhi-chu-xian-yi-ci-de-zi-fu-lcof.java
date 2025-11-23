public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findIntegers(List<Integer> nums) {
        int n = nums.size();
        List<List<Integer>> result = new ArrayList<>();
        if (n == 0) return result;

        List<Integer> path = new ArrayList<>();
        backtrack(nums, 0, path, result);
        return result;
    }

    private void backtrack(List<Integer> nums, int start, List<Integer> path, List<List<Integer>> result) {
        if (path.size() >= 2) {
            result.add(new ArrayList<>(path));
        }

        for (int i = start; i < nums.size(); i++) {
            if (path.size() >= 1 && nums.get(i) <= nums.get(i - 1)) {
                continue;
            }
            path.add(nums.get(i));
            backtrack(nums, i + 1, path, result);
            path.remove(path.size() - 1);
        }
    }
}
}