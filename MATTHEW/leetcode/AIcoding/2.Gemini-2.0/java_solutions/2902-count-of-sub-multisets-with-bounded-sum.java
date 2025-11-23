class Solution {
    public int countSubMultisets(List<Integer> nums, int l, int r) {
        int MOD = 1000000007;
        int maxVal = 0;
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
            maxVal = Math.max(maxVal, num);
        }

        int zeroCount = countMap.getOrDefault(0, 0);
        countMap.remove(0);

        int[] dp = new int[r + 1];
        dp[0] = 1;

        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            int num = entry.getKey();
            int count = entry.getValue();
            for (int j = num; j <= r; j++) {
                for (int k = 1; k <= count && j - num * k >= 0; k++) {
                    dp[j] = (dp[j] + dp[j - num * k]) % MOD;
                }
            }
        }

        long result = 0;
        for (int i = l; i <= r; i++) {
            result = (result + dp[i]) % MOD;
        }

        result = (result * (zeroCount + 1)) % MOD;
        return (int) result;
    }
}