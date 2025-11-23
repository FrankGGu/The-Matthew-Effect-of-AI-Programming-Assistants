var minNumberOfSemesters = function(n, relations, k) {
    const pre = new Array(n).fill(0);
    for (const [u, v] of relations) {
        pre[v - 1] |= 1 << (u - 1);
    }

    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;

        let available = 0;
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0 && (pre[i] & mask) === pre[i]) {
                available |= 1 << i;
            }
        }

        for (let subset = available; subset > 0; subset = (subset - 1) & available) {
            if (countBits(subset) <= k) {
                dp[mask | subset] = Math.min(dp[mask | subset], dp[mask] + 1);
            }
        }
    }

    return dp[(1 << n) - 1];
};

function countBits(n) {
    let count = 0;
    while (n > 0) {
        count++;
        n &= n - 1;
    }
    return count;
}