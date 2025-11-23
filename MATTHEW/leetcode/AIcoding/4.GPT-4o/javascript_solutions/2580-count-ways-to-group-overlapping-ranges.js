var countWays = function(ranges) {
    const mod = 1e9 + 7;
    ranges.sort((a, b) => a[0] - b[0]);
    let dp = 1;
    let end = ranges[0][1];
    let count = 1;

    for (let i = 1; i < ranges.length; i++) {
        if (ranges[i][0] > end) {
            dp = (dp * (count + 1)) % mod;
            count = 1;
            end = ranges[i][1];
        } else {
            count++;
            end = Math.max(end, ranges[i][1]);
        }
    }

    dp = (dp * (count + 1)) % mod;
    return dp;
};