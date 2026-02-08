class Solution {
    public int minSumOfLengths(int[] arr, int target) {
        int n = arr.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        int sum = 0, res = Integer.MAX_VALUE;
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);

        for (int i = 0; i < n; i++) {
            sum += arr[i];
            if (map.containsKey(sum - target)) {
                int prev = map.get(sum - target);
                if (prev >= 0 && dp[prev] != Integer.MAX_VALUE) {
                    res = Math.min(res, dp[prev] + i - prev);
                }
                dp[i] = Math.min(dp[i == 0 ? 0 : i - 1], i - prev);
            } else {
                dp[i] = i == 0 ? dp[i] : dp[i - 1];
            }
            map.put(sum, i);
        }

        return res == Integer.MAX_VALUE ? -1 : res;
    }
}