class Solution {
    public int minOperations(List<Integer> nums) {
        int n = nums.size();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int num : nums) {
            int[] newDp = new int[n + 1];
            Arrays.fill(newDp, Integer.MAX_VALUE);
            for (int i = 0; i <= n; i++) {
                if (dp[i] == Integer.MAX_VALUE) continue;
                if (i == 0 || num >= nums.get(dp[i] - 1)) {
                    int len = i + 1;
                    if (len <= n) {
                        newDp[len] = Math.min(newDp[len], (len == 1 ? 0 : dp[i]) + 1);
                        if (len == 1) {
                            nums.set(0, num);
                            newDp[len] = 1;
                        } else {
                            nums.set(dp[i], num);
                            newDp[len] = dp[i] + 1;
                        }
                    }
                }
            }
            dp = new int[n + 1];
            Arrays.fill(dp, Integer.MAX_VALUE);
            for (int i = 0; i <= n; i++) {
                dp[i] = newDp[i];
            }
        }

        for (int i = n; i >= 0; i--) {
            if (dp[i] != Integer.MAX_VALUE) {
                return n - i;
            }
        }
        return n;
    }
}