class Solution {
    public boolean canDistribute(int[] nums, int[] quantity) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }
        List<Integer> counts = new ArrayList<>(freqMap.values());
        int m = quantity.length;
        int n = counts.size();
        int[] quantitySum = new int[1 << m];
        for (int mask = 0; mask < (1 << m); mask++) {
            int sum = 0;
            for (int i = 0; i < m; i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += quantity[i];
                }
            }
            quantitySum[mask] = sum;
        }
        boolean[][] dp = new boolean[n + 1][1 << m];
        dp[0][0] = true;
        for (int i = 1; i <= n; i++) {
            int cnt = counts.get(i - 1);
            for (int mask = 0; mask < (1 << m); mask++) {
                if (dp[i - 1][mask]) {
                    dp[i][mask] = true;
                    continue;
                }
                for (int subset = mask; subset > 0; subset = (subset - 1) & mask) {
                    if (quantitySum[subset] <= cnt && dp[i - 1][mask ^ subset]) {
                        dp[i][mask] = true;
                        break;
                    }
                }
            }
        }
        return dp[n][(1 << m) - 1];
    }
}