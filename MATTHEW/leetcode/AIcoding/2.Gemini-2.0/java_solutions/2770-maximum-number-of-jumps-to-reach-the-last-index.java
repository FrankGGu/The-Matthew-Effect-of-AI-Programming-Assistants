class Solution {
    public int maxJumps(int[] arr, int d) {
        int n = arr.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> arr[a] - arr[b]);
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        int ans = 1;
        for (int i = 0; i < n; i++) {
            int index = indices[i];
            for (int j = index - 1; j >= Math.max(0, index - d); j--) {
                if (arr[j] >= arr[index]) {
                    break;
                }
                dp[index] = Math.max(dp[index], dp[j] + 1);
            }
            for (int j = index + 1; j <= Math.min(n - 1, index + d); j++) {
                if (arr[j] >= arr[index]) {
                    break;
                }
                dp[index] = Math.max(dp[index], dp[j] + 1);
            }
            ans = Math.max(ans, dp[index]);
        }
        return ans;
    }
}