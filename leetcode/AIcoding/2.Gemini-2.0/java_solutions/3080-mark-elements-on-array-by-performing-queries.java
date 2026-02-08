import java.util.Arrays;

class Solution {
    public int[] markElements(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int[] ans = new int[m];
        boolean[] marked = new boolean[n];
        Arrays.fill(ans, -1);

        for (int i = 0; i < m; i++) {
            int type = queries[i][0];
            int index = queries[i][1];

            if (type == 0) {
                if (!marked[index]) {
                    marked[index] = true;
                    ans[i] = index;
                }
            } else {
                int val = queries[i][2];
                for (int j = 0; j < n; j++) {
                    if (nums[j] == val && !marked[j]) {
                        marked[j] = true;
                        ans[i] = j;
                        break;
                    }
                }
            }
        }

        return ans;
    }
}