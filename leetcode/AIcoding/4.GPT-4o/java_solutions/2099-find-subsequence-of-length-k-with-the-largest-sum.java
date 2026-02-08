import java.util.Arrays;

class Solution {
    public int[] maxSubsequence(int[] nums, int k) {
        int n = nums.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> nums[b] - nums[a]);
        Arrays.sort(indices, 0, k);
        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = nums[indices[i]];
        }
        return result;
    }
}