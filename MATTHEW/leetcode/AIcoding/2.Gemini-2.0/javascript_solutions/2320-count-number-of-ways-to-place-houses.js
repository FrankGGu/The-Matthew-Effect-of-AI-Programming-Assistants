var countHousePlacements = function(n) {
    const MOD = 1000000007;
    let a = 1;
    let b = 1;
    for (let i = 2; i <= n; i++) {
        let temp = b;
        b = (a + b) % MOD;
        a = temp;
    }
    return (BigInt(b) * BigInt(b)) % BigInt(MOD);
};