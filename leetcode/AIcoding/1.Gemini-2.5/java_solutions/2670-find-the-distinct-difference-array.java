import java.util.HashSet;
import java.util.Set;

class Solution {
    public int[] distinctDifferenceArray(int[] nums) {
        int n = nums.length;
        int[] prefCounts = new int[n];
        int[] suffCounts = new int[n];
        int[] result = new int[n];

        Set<Integer> prefixSet = new HashSet<>();
        for (int i = 0; i < n; i++) {
            prefixSet.add(nums[i]);
            prefCounts[i] = prefixSet.size();
        }

        Set<Integer> suffixSet = new HashSet<>();
        for (int i = n - 1; i >= 0; i--) {
            suffCounts[i] = suffixSet.size();
            suffixSet.add(nums[i]);
        }

        for (int i = 0; i < n; i++) {
            result[i] = prefCounts[i] - suffCounts[i];
        }

        return result;
    }
}