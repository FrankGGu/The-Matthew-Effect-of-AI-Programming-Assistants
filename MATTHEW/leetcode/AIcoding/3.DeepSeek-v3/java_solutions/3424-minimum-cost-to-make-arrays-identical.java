class Solution {
    public long makeArrayIncreasing(int[] arr1, int[] arr2) {
        Arrays.sort(arr2);
        List<Integer> uniqueArr2 = new ArrayList<>();
        for (int i = 0; i < arr2.length; i++) {
            if (i == 0 || arr2[i] != arr2[i - 1]) {
                uniqueArr2.add(arr2[i]);
            }
        }
        int m = arr1.length;
        int n = uniqueArr2.size();
        long[][] dp = new long[m][n + 1];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dp[i], Long.MAX_VALUE);
        }
        for (int j = 0; j <= n; j++) {
            if (j == 0) {
                dp[0][j] = 0;
            } else {
                dp[0][j] = 1;
            }
        }
        for (int i = 1; i < m; i++) {
            for (int j = 0; j <= n; j++) {
                int currentVal = j == 0 ? arr1[i] : uniqueArr2.get(j - 1);
                if (arr1[i - 1] < currentVal && dp[i - 1][0] != Long.MAX_VALUE) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][0]);
                }
                for (int k = 1; k <= n; k++) {
                    int prevVal = uniqueArr2.get(k - 1);
                    if (prevVal < currentVal && dp[i - 1][k] != Long.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + (j == 0 ? 0 : 1));
                    }
                }
            }
        }
        long result = Long.MAX_VALUE;
        for (int j = 0; j <= n; j++) {
            result = Math.min(result, dp[m - 1][j]);
        }
        return result == Long.MAX_VALUE ? -1 : result;
    }
}