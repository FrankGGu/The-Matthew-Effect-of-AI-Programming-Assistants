import java.util.Arrays;

public class Solution {
    public int[] maximizeXor(int[] nums, int[][] queries) {
        Arrays.sort(nums);
        int m = queries.length;
        int[] result = new int[m];
        int[][] augmentedQueries = new int[m][3];

        for (int i = 0; i < m; i++) {
            augmentedQueries[i] = new int[]{queries[i][1], queries[i][0], i};
        }

        Arrays.sort(augmentedQueries, (a, b) -> Integer.compare(a[0], b[0]));

        int index = 0;
        int maxXor = 0;
        for (int[] query : augmentedQueries) {
            int limit = query[0];
            int x = query[1];
            int queryIndex = query[2];

            while (index < nums.length && nums[index] <= limit) {
                maxXor = Math.max(maxXor, nums[index]);
                index++;
            }

            result[queryIndex] = (maxXor ^ x);
        }

        return result;
    }
}