class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            Map<Integer, Integer> freq = new HashMap<>();
            int unique = 0;
            for (int j = i - 1; j >= 0; j--) {
                int num = nums[j];
                freq.put(num, freq.getOrDefault(num, 0) + 1);
                if (freq.get(num) == 1) {
                    unique++;
                } else if (freq.get(num) == 2) {
                    unique--;
                }
                int cost = k + (i - j) - unique;
                dp[i] = Math.min(dp[i], dp[j] + cost);
            }
        }

        return dp[n];
    }
}