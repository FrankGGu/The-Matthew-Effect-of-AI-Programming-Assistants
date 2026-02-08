var numOfWays = function(n) {
    const MOD = 1e9 + 7;
    let same = 6, diff = 6;

    for (let i = 2; i <= n; i++) {
        let newSame = diff * 2 % MOD;
        let newDiff = (same + diff * 2) % MOD;
        same = newSame;
        diff = newDiff;
    }

    return (same + diff) % MOD;
};