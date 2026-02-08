var countWays = function(ranges) {
    ranges.sort((a, b) => a[0] - b[0]);
    let merged = [];
    let current = ranges[0];
    for (let i = 1; i < ranges.length; i++) {
        if (ranges[i][0] <= current[1]) {
            current[1] = Math.max(current[1], ranges[i][1]);
        } else {
            merged.push(current);
            current = ranges[i];
        }
    }
    merged.push(current);

    let n = merged.length;
    let mod = 1000000007;
    let ans = 1;
    for (let i = 0; i < n; i++) {
        ans = (ans * 2) % mod;
    }
    return ans;
};