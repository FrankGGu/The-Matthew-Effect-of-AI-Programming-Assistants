var largestNumber = function(cost, target) {
    const dp = Array(target + 1).fill('');
    dp[0] = '';

    for (let t = 1; t <= target; t++) {
        for (let i = 0; i < cost.length; i++) {
            const c = cost[i];
            const digit = i + 1;

            if (t >= c) {
                const prev = dp[t - c];
                if (prev !== null) {
                    const current = prev + digit;
                    if (dp[t] === '') {
                        dp[t] = current;
                    } else {
                        if (current.length > dp[t].length) {
                            dp[t] = current;
                        } else if (current.length === dp[t].length && current > dp[t]) {
                            dp[t] = current;
                        }
                    }
                }
            }
        }
    }
    if (dp[target] === '') return '0';
    return dp[target];
};