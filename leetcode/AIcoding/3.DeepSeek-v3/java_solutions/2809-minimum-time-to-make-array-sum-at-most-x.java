class Solution {
    public int minimumTime(List<Integer> nums1, List<Integer> nums2, int x) {
        int n = nums1.size();
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums2.get(i);
            pairs[i][1] = nums1.get(i);
        }
        Arrays.sort(pairs, (a, b) -> a[0] - b[0]);

        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            int a = pairs[i][0], b = pairs[i][1];
            for (int j = i + 1; j > 0; j--) {
                dp[j] = Math.max(dp[j], dp[j - 1] + a * j + b);
            }
        }

        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        for (int t = 0; t <= n; t++) {
            if (sum1 + sum2 * t - dp[t] <= x) {
                return t;
            }
        }
        return -1;
    }
}