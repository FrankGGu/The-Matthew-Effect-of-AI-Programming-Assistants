var minNumberOfSemesters = function(n, dependencies, k) {
    const indegree = new Array(n).fill(0);
    const pre = new Array(n).fill(0);

    for (const [u, v] of dependencies) {
        indegree[v - 1]++;
        pre[v - 1] |= (1 << (u - 1));
    }

    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;

        let available = 0;
        for (let i = 0; i < n; i++) {
            if (!(mask & (1 << i)) && (pre[i] & mask) === pre[i]) {
                available |= (1 << i);
            }
        }

        for (let submask = available; submask > 0; submask = (submask - 1) & available) {
            if (countSetBits(submask) <= k) {
                dp[mask | submask] = Math.min(dp[mask | submask], dp[mask] + 1);
            }
        }
    }

    return dp[(1 << n) - 1];

    function countSetBits(n) {
        let count = 0;
        while (n > 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    }
};