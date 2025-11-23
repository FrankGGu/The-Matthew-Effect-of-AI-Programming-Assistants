var numberWays = function(people) {
    const MOD = 10 ** 9 + 7;
    const numPeople = people.length;
    const allMask = (1 << numPeople) - 1;

    const hatsToPeople = Array(41).fill(0).map(() => []);
    let maxHatId = 0;

    for (let i = 0; i < numPeople; i++) {
        for (const hatId of people[i]) {
            hatsToPeople[hatId].push(i);
            maxHatId = Math.max(maxHatId, hatId);
        }
    }

    const dp = Array(1 << numPeople).fill(0);
    dp[0] = 1;

    for (let hatId = 1; hatId <= maxHatId; hatId++) {
        if (hatsToPeople[hatId].length === 0) {
            continue;
        }

        for (let mask = allMask; mask >= 0; mask--) {
            if (dp[mask] === 0) {
                continue;
            }

            for (const personId of hatsToPeople[hatId]) {
                if (!((mask >> personId) & 1)) {
                    const newMask = mask | (1 << personId);
                    dp[newMask] = (dp[newMask] + dp[mask]) % MOD;
                }
            }
        }
    }

    return dp[allMask];
};