import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int[] smallestTrimmedNumbers(String[] nums, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i][0];
            int trim = queries[i][1];
            int n = nums.length;
            int[][] indices = new int[n][2];
            for (int j = 0; j < n; j++) {
                indices[j][0] = j;
                indices[j][1] = Integer.parseInt(nums[j].substring(nums[j].length() - trim));
            }

            Arrays.sort(indices, (a, b) -> {
                String sa = nums[a[0]].substring(nums[a[0]].length() - trim);
                String sb = nums[b[0]].substring(nums[b[0]].length() - trim);
                int comparison = sa.compareTo(sb);
                if (comparison != 0) {
                    return comparison;
                } else {
                    return a[0] - b[0];
                }
            });

            result[i] = indices[k - 1][0];
        }
        return result;
    }
}