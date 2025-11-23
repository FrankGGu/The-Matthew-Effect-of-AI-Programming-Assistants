class Solution {
    public int[] colorTheArray(int n, int[][] queries) {
        int[] nums = new int[n];
        int[] ans = new int[queries.length];
        int same = 0;
        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int color = queries[i][1];
            if (nums[index] != 0) {
                if (index > 0 && nums[index - 1] == nums[index]) {
                    same--;
                }
                if (index < n - 1 && nums[index + 1] == nums[index]) {
                    same--;
                }
            }
            nums[index] = color;
            if (index > 0 && nums[index - 1] == nums[index]) {
                same++;
            }
            if (index < n - 1 && nums[index + 1] == nums[index]) {
                same++;
            }
            ans[i] = same;
        }
        return ans;
    }
}