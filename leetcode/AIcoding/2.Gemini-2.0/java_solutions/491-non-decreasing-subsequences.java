import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<List<Integer>> findSubsequences(int[] nums) {
        Set<List<Integer>> result = new HashSet<>();
        List<Integer> current = new ArrayList<>();
        findSubsequencesHelper(nums, 0, current, result);
        return new ArrayList<>(result);
    }

    private void findSubsequencesHelper(int[] nums, int index, List<Integer> current, Set<List<Integer>> result) {
        if (current.size() >= 2) {
            result.add(new ArrayList<>(current));
        }

        for (int i = index; i < nums.length; i++) {
            if (current.isEmpty() || nums[i] >= current.get(current.size() - 1)) {
                current.add(nums[i]);
                findSubsequencesHelper(nums, i + 1, current, result);
                current.remove(current.size() - 1);
            }
        }
    }
}