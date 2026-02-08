import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> getLongestSubsequence(int[] nums, int[] groups) {
        List<Integer> result = new ArrayList<>();
        int groupIndex = 0;
        for (int i = 0; i < nums.length; i++) {
            if (groupIndex < groups.length && nums[i] == groups[groupIndex]) {
                result.add(nums[i]);
                groupIndex++;
            }
        }
        return result;
    }
}