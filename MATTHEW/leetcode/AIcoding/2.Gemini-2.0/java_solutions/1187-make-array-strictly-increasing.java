import java.util.Arrays;
import java.util.TreeSet;

class Solution {
    public int makeArrayIncreasing(int[] arr1, int[] arr2) {
        TreeSet<Integer> set = new TreeSet<>();
        for (int num : arr2) {
            set.add(num);
        }

        int n = arr1.length;
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        dp[0][0] = -1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                if (arr1[i - 1] > dp[i - 1][j]) {
                    dp[i][j] = arr1[i - 1];
                }
                if (j > 0 && dp[i - 1][j - 1] != Integer.MAX_VALUE) {
                    Integer next = set.higher(dp[i - 1][j - 1]);
                    if (next != null) {
                        dp[i][j] = Math.min(dp[i][j], next);
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
}