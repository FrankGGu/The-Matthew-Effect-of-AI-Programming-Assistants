var minimumWhiteTiles = function(floor, numCarpets, carpetLen) {
    const n = floor.length;
    const dp = Array(n + 1).fill(0);
    const prefixSum = Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + (floor[i] === '1' ? 1 : 0);
    }

    const totalWhite = prefixSum[n];

    for (let i = 0; i <= n; i++) {
        dp[i] = totalWhite - prefixSum[i];
    }

    for (let k = 1; k <= numCarpets; k++) {
        const newDp = [...dp];
        let maxCover = 0;
        for (let i = 0; i <= n; i++) {
            if (i > carpetLen) {
                maxCover = Math.max(maxCover, dp[i - carpetLen]);
            }
            newDp[i] = Math.min(newDp[i], maxCover + totalWhite - prefixSum[i]);
        }
        dp = newDp;
    }

    return dp[n];
};