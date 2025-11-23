class Solution {
    public int minChanges(int[] nums, int k) {
        int n = nums.length;
        int[][] freq = new int[k][1024];
        for (int i = 0; i < n; i++) {
            freq[i % k][nums[i]]++;
        }

        int[][] dp = new int[k + 1][1024];
        for (int i = 0; i <= k; i++) {
            Arrays.fill(dp[i], n);
        }
        dp[0][0] = 0;

        int prevMin = 0;
        for (int i = 0; i < k; i++) {
            int total = (n - i + k - 1) / k;
            int minVal = n;
            int[] temp = new int[1024];
            Arrays.fill(temp, prevMin + total);

            for (int j = 0; j < 1024; j++) {
                if (dp[i][j] == n) continue;
                for (int l = i; l < n; l += k) {
                    int num = nums[l];
                    int next = j ^ num;
                    temp[next] = Math.min(temp[next], dp[i][j] + total - freq[i][num]);
                }
            }

            prevMin = n;
            for (int j = 0; j < 1024; j++) {
                dp[i + 1][j] = temp[j];
                prevMin = Math.min(prevMin, dp[i + 1][j]);
            }
        }

        return dp[k][0];
    }
}