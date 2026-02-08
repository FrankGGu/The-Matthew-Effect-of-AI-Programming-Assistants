import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    Set<List<Integer>> result = new HashSet<>();
    List<Integer> tempList = new ArrayList<>();

    public List<List<Integer>> findSubsequences(int[] nums) {
        backtrack(0, nums);
        return new ArrayList<>(result);
    }

    private void backtrack(int start, int[] nums) {
        if (tempList.size() >= 2) {
            result.add(new ArrayList<>(tempList));
        }

        Set<Integer> used = new HashSet<>();
        for (int i = start; i < nums.length; i++) {
            if (!tempList.isEmpty() && nums[i] < tempList.get(tempList.size() - 1)) {
                continue;
            }

            if (used.contains(nums[i])) {
                continue;
            }

            used.add(nums[i]);
            tempList.add(nums[i]);
            backtrack(i + 1, nums);
            tempList.remove(tempList.size() - 1);
        }
    }
}