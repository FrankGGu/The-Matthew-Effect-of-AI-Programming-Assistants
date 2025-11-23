import java.util.Arrays;

public class Solution {
    public int[] minAbsoluteDifference(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int[] result = new int[m];

        Arrays.sort(nums);

        for (int i = 0; i < m; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            int minDiff = Integer.MAX_VALUE;

            for (int j = left; j <= right; j++) {
                for (int k = j + 1; k <= right; k++) {
                    minDiff = Math.min(minDiff, Math.abs(nums[j] - nums[k]));
                }
            }
            result[i] = minDiff == Integer.MAX_VALUE ? -1 : minDiff;
        }

        return result;
    }
}