var maxHeight = function(cuboids) {
    const n = cuboids.length;

    for (let i = 0; i < n; i++) {
        cuboids[i].sort((a, b) => a - b);
    }

    cuboids.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        if (a[1] !== b[1]) return a[1] - b[1];
        return a[2] - b[2];
    });

    const dp = new Array(n).fill(0);
    let overallMaxHeight = 0;

    for (let i = 0; i < n; i++) {
        dp[i] = cuboids[i][2]; 

        for (let j = 0; j < i; j++) {
            if (cuboids[j][0] <= cuboids[i][0] &&
                cuboids[j][1] <= cuboids[i][1] &&
                cuboids[j][2] <= cuboids[i][2]) {
                dp[i] = Math.max(dp[i], dp[j] + cuboids[i][2]);
            }
        }
        overallMaxHeight = Math.max(overallMaxHeight, dp[i]);
    }

    return overallMaxHeight;
};