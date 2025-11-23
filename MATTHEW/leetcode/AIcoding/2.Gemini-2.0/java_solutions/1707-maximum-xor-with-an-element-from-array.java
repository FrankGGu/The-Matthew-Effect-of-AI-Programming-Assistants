import java.util.Arrays;

class Solution {
    public int[] maximizeXor(int[] nums, int[][] queries) {
        Arrays.sort(nums);
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int x = queries[i][0];
            int m = queries[i][1];
            int max_xor = -1;
            for (int j = 0; j < nums.length; j++) {
                if (nums[j] <= m) {
                    max_xor = Math.max(max_xor, x ^ nums[j]);
                } else {
                    break;
                }
            }
            result[i] = max_xor;
        }
        return result;
    }
}