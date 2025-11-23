var maxHeight = function(cuboids) {
    for (let cuboid of cuboids) {
        cuboid.sort((a, b) => a - b);
    }

    cuboids.sort((a, b) => {
        if (a[0] !== b[0]) return b[0] - a[0];
        if (a[1] !== b[1]) return b[1] - a[1];
        return b[2] - a[2];
    });

    let n = cuboids.length;
    let dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i] = cuboids[i][2];
        for (let j = 0; j < i; j++) {
            if (cuboids[j][0] >= cuboids[i][0] &&
                cuboids[j][1] >= cuboids[i][1] &&
                cuboids[j][2] >= cuboids[i][2]) {
                dp[i] = Math.max(dp[i], dp[j] + cuboids[i][2]);
            }
        }
    }

    let max_height = 0;
    for (let height of dp) {
        max_height = Math.max(max_height, height);
    }

    return max_height;
};