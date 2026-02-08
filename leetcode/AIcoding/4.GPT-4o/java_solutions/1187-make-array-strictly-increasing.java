import java.util.Arrays;

public class Solution {
    public int makeArrayIncreasing(int[] arr1, int[] arr2) {
        Arrays.sort(arr2);
        int n = arr1.length;
        int m = arr2.length;
        int[][] dp = new int[n + 1][n + 1];
        for (int[] d : dp) {
            Arrays.fill(d, Integer.MAX_VALUE);
        }
        dp[0][0] = -1;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= i; j++) {
                if (dp[i][j] == Integer.MAX_VALUE) continue;
                if (arr1[i] > dp[i][j]) {
                    dp[i + 1][j] = Math.min(dp[i + 1][j], arr1[i]);
                }
                if (j < m) {
                    int idx = binarySearch(arr2, dp[i][j]);
                    if (idx < m) {
                        dp[i + 1][j + 1] = Math.min(dp[i + 1][j + 1], arr2[idx]);
                    }
                }
            }
        }

        for (int j = 0; j <= n; j++) {
            if (dp[n][j] != Integer.MAX_VALUE) {
                return j;
            }
        }
        return -1;
    }

    private int binarySearch(int[] arr2, int target) {
        int left = 0, right = arr2.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr2[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}