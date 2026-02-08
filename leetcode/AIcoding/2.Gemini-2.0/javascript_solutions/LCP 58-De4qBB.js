var numWays = function(n) {
    const MOD = 1000000007;
    if (n === 1) return 12;
    if (n === 2) return 54;
    let triple = 12;
    let double = 54;
    for (let i = 3; i <= n; i++) {
        let temp = (triple * 3 + double * 2) % MOD;
        triple = double;
        double = temp * 3 % MOD;
    }
    return double;
};