class Solution {
    public int maxJumps(int[] arr, int d) {
        int n = arr.length;
        int[] dp = new int[n];
        int[] indices = new int[n];
        for (int i = 0; i < n; i++) indices[i] = i;

        Arrays.sort(indices, (a, b) -> arr[a] - arr[b]);

        int maxJumps = 0;

        for (int idx : indices) {
            dp[idx] = 1;
            for (int jump = 1; jump <= d; jump++) {
                if (idx + jump < n && arr[idx + jump] < arr[idx]) {
                    dp[idx] = Math.max(dp[idx], dp[idx + jump] + 1);
                } else {
                    break;
                }
            }
            for (int jump = 1; jump <= d; jump++) {
                if (idx - jump >= 0 && arr[idx - jump] < arr[idx]) {
                    dp[idx] = Math.max(dp[idx], dp[idx - jump] + 1);
                } else {
                    break;
                }
            }
            maxJumps = Math.max(maxJumps, dp[idx]);
        }

        return maxJumps;
    }
}