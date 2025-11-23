import java.util.*;

class Solution {
    public List<List<Integer>> findSubsequences(int[] nums) {
        Set<List<Integer>> result = new HashSet<>();
        backtrack(nums, 0, new ArrayList<>(), result);
        return new ArrayList<>(result);
    }

    private void backtrack(int[] nums, int start, List<Integer> tempList, Set<List<Integer>> result) {
        if (tempList.size() > 1) {
            result.add(new ArrayList<>(tempList));
        }
        for (int i = start; i < nums.length; i++) {
            if (tempList.isEmpty() || nums[i] >= tempList.get(tempList.size() - 1)) {
                tempList.add(nums[i]);
                backtrack(nums, i + 1, tempList, result);
                tempList.remove(tempList.size() - 1);
            }
        }
    }
}