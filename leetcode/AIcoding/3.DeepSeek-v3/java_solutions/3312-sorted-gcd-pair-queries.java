class Solution {
    public int[] solve(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int[] res = new int[m];

        for (int i = 0; i < m; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            int maxGcd = 0;

            for (int j = 0; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    if (nums[j] >= x && nums[k] <= y) {
                        maxGcd = Math.max(maxGcd, gcd(nums[j], nums[k]));
                    }
                }
            }

            res[i] = maxGcd == 0 ? -1 : maxGcd;
        }

        return res;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}