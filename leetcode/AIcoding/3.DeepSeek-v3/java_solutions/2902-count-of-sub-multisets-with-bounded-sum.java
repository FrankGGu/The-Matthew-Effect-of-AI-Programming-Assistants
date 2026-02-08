class Solution {
    public int countSubMultisets(List<Integer> nums, int l, int r) {
        int MOD = (int)1e9 + 7;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int[] dp = new int[r + 1];
        dp[0] = 1;

        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            int num = entry.getKey();
            int cnt = entry.getValue();
            for (int j = r; j >= 0; --j) {
                for (int k = 1; k <= cnt; ++k) {
                    if (j - k * num >= 0) {
                        dp[j] = (dp[j] + dp[j - k * num]) % MOD;
                    }
                }
            }
        }

        int res = 0;
        for (int i = l; i <= r; ++i) {
            res = (res + dp[i]) % MOD;
        }
        return res;
    }
}