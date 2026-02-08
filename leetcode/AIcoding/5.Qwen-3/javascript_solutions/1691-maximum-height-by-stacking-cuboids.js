function maxHeight(cuboids) {
    cuboids.sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2]);
    const n = cuboids.length;
    const dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i] = cuboids[i][2];
        for (let j = 0; j < i; j++) {
            if (cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2]) {
                dp[i] = Math.max(dp[i], dp[j] + cuboids[i][2]);
            }
        }
    }

    return Math.max(...dp);
}