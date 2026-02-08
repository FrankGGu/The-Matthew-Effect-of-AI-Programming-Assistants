function minCostGoodCaption(words, good, bad, cost) {
    const n = words.length;
    const m = good.length;
    const p = bad.length;

    const dp = Array(1 << m).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        const newDp = Array(1 << m).fill(Infinity);
        for (let mask = 0; mask < (1 << m); mask++) {
            if (dp[mask] === Infinity) continue;

            // Skip the current word
            newDp[mask] = Math.min(newDp[mask], dp[mask]);

            // Use the current word
            let newMask = mask;
            for (let j = 0; j < m; j++) {
                if (words[i].includes(good[j])) {
                    newMask |= (1 << j);
                }
            }

            let badPresent = false;
            for (let j = 0; j < p; j++) {
                if (words[i].includes(bad[j])) {
                    badPresent = true;
                    break;
                }
            }

            if (!badPresent) {
                newDp[newMask] = Math.min(newDp[newMask], dp[mask] + cost[i]);
            }
        }
        for (let mask = 0; mask < (1 << m); mask++) {
            dp[mask] = newDp[mask];
        }
    }

    let result = dp[(1 << m) - 1];
    return result === Infinity ? -1 : result;
}