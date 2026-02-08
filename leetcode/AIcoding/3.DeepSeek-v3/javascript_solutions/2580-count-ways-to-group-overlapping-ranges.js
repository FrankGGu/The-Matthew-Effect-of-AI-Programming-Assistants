var countWays = function(ranges) {
    ranges.sort((a, b) => a[0] - b[0]);
    let merged = [];
    for (let range of ranges) {
        if (merged.length === 0 || merged[merged.length - 1][1] < range[0]) {
            merged.push(range);
        } else {
            merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], range[1]);
        }
    }
    const n = merged.length;
    let result = 1;
    const MOD = 1e9 + 7;
    for (let i = 0; i < n; i++) {
        result = (result * 2) % MOD;
    }
    return result;
};