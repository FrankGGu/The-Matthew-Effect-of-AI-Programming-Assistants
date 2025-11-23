import java.util.Arrays;

class Solution {
    public int minimumTime(int[] nums1, int[] nums2, int x) {
        int n = nums1.length;
        int sum = Arrays.stream(nums1).sum();
        sum += Arrays.stream(nums2).sum();
        if (sum <= x) {
            return 0;
        }

        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> Integer.compare(nums2[a], nums2[b]));

        int[][] dp = new int[n + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            int index = indices[i - 1];
            for (int j = 1; j <= i; j++) {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i - 1][j - 1] + nums1[index] + (long) nums2[index] * j);
            }
        }

        for (int k = 1; k <= n; k++) {
            if (sum + (long) Arrays.stream(nums2).sum() * k - dp[n][k] <= x) {
                return k;
            }
        }

        return -1;
    }
}