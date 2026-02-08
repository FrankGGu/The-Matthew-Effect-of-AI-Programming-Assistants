var minimumCost = function(s, target, original, changed, cost) {
    const n = s.length;
    const m = target.length;
    const k = original.length;

    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + (s[i - 1] === target[i - 1] ? 0 : Infinity);

        for (let j = 0; j < k; j++) {
            const orig = original[j];
            const change = changed[j];
            const c = cost[j];

            if (i >= orig.length) {
                const sub = s.substring(i - orig.length, i);
                if (sub === orig) {
                    const targetSub = target.substring(i - orig.length, i);
                    if (targetSub === change) {
                        dp[i] = Math.min(dp[i], dp[i - orig.length] + c);
                    }
                }
            }
        }

        if (s[i - 1] === target[i - 1]) {
            dp[i] = Math.min(dp[i], dp[i-1]);
        }

        if (s[i-1] !== target[i-1]) {
            let found = false;
            for (let j = 0; j < k; j++) {
                if (original[j].length === 1 && original[j][0] === s[i-1] && changed[j][0] === target[i-1]) {
                    dp[i] = Math.min(dp[i], dp[i-1] + cost[j]);
                    found = true;
                }
            }
            if (!found) {
                if (s[i-1] !== target[i-1]) {
                    if (original.every(x => x.length > 1 || x[0] !== s[i-1])) {
                        dp[i] = Math.min(dp[i], Infinity);
                    }
                }
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};