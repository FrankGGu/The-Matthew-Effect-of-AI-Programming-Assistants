class Solution {
    public int[] colorTheArray(int n, int[][] queries) {
        int[] nums = new int[n];
        int[] res = new int[queries.length];
        int count = 0;

        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int color = queries[i][1];

            if (nums[index] != 0) {
                if (index > 0 && nums[index] == nums[index - 1]) {
                    count--;
                }
                if (index < n - 1 && nums[index] == nums[index + 1]) {
                    count--;
                }
            }

            nums[index] = color;

            if (index > 0 && nums[index] == nums[index - 1]) {
                count++;
            }
            if (index < n - 1 && nums[index] == nums[index + 1]) {
                count++;
            }

            res[i] = count;
        }

        return res;
    }
}