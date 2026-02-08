var profitableSchemes = function(n, minProfit, group, profit) {
    const MOD = 10**9 + 7;

    // dp[j][k] represents the number of ways to achieve a total profit of at least 'k'
    // using exactly 'j' members.
    // The profit 'k' is capped at minProfit.
    const dp = Array(n + 1).fill(0).map(() => Array(minProfit + 1).fill(0));

    // Base case: one way to achieve 0 profit with 0 members (by choosing no schemes).
    dp[0][0] = 1;

    // Iterate through each scheme
    for (let i = 0; i < group.length; i++) {
        const membersNeeded = group[i];
        const currentProfit = profit[i];

        // Iterate members from max 'n' down to 'membersNeeded'
        // This ensures that we are using values from the previous iteration (before considering current scheme)
        // or from states that don't include the current scheme.
        for (let j = n; j >= membersNeeded; j--) {
            // Iterate profit from 'minProfit' down to '0'
            for (let k = minProfit; k >= 0; k--) {
                // Calculate the profit achieved if we include the current scheme.
                // Cap the profit at minProfit.
                const newProfitIndex = Math.min(minProfit, k + currentProfit);

                // Add the ways to achieve 'k' profit with 'j - membersNeeded' members
                // to the ways to achieve 'newProfitIndex' with 'j' members.
                dp[j][newProfitIndex] = (dp[j][newProfitIndex] + dp[j - membersNeeded][k]) % MOD;
            }
        }
    }

    // The total number of profitable schemes is the sum of all ways
    // where the profit is at least 'minProfit' (which is stored in dp[j][minProfit])
    // for all possible numbers of members 'j' from 0 to n.
    let totalSchemes = 0;
    for (let j = 0; j <= n; j++) {
        totalSchemes = (totalSchemes + dp[j][minProfit]) % MOD;
    }

    return totalSchemes;
};