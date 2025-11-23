class Solution {
    public int minimumOperations(int[] nums) {
        int n = nums.length;
        int[] dp = new int[1 << n];
        for (int i = 1; i < (1 << n); i++) {
            dp[i] = Integer.MAX_VALUE;
        }

        for (int mask = 1; mask < (1 << n); mask++) {
            int count = Integer.bitCount(mask);
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    int prevMask = mask ^ (1 << i);
                    int cost = 0;
                    if (count == 1) {
                        cost = nums[i];
                    } else {
                        cost = 0;
                    }
                    dp[mask] = Math.min(dp[mask], dp[prevMask] + cost);
                }
            }

            if (count % 3 == 0) {
                for (int i = 0; i < n; i++) {
                    if ((mask & (1 << i)) != 0) {
                        for (int j = i + 1; j < n; j++) {
                            if ((mask & (1 << j)) != 0) {
                                for (int k = j + 1; k < n; k++) {
                                    if ((mask & (1 << k)) != 0) {
                                        int prevMask = mask ^ (1 << i) ^ (1 << j) ^ (1 << k);
                                        dp[mask] = Math.min(dp[mask], dp[prevMask] + 1);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}