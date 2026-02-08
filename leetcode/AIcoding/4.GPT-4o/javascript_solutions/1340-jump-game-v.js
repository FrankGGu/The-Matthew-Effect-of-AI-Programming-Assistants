var maxJumps = function(arr, d) {
    const n = arr.length;
    const dp = new Array(n).fill(0);
    const indices = Array.from({ length: n }, (_, i) => i).sort((a, b) => arr[a] - arr[b]);

    for (let index of indices) {
        dp[index] = 1;
        for (let i = 1; i <= d; i++) {
            if (index + i < n && arr[index + i] < arr[index]) {
                dp[index] = Math.max(dp[index], dp[index + i] + 1);
            }
            if (index - i >= 0 && arr[index - i] < arr[index]) {
                dp[index] = Math.max(dp[index], dp[index - i] + 1);
            }
        }
    }

    return Math.max(...dp);
};