import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int[] distinctDifferenceArray(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            Set<Integer> prefix = new HashSet<>();
            Set<Integer> suffix = new HashSet<>();
            for (int j = 0; j <= i; j++) {
                prefix.add(nums[j]);
            }
            for (int j = i + 1; j < n; j++) {
                suffix.add(nums[j]);
            }
            result[i] = prefix.size() - suffix.size();
        }
        return result;
    }
}