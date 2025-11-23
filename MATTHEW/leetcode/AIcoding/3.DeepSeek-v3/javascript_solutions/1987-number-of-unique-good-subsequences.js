var numberOfUniqueGoodSubsequences = function(binary) {
    const MOD = 1e9 + 7;
    let dp0 = 0, dp1 = 0, has0 = 0;
    for (let i = binary.length - 1; i >= 0; --i) {
        if (binary[i] === '0') {
            has0 = 1;
            dp0 = (dp0 + dp1 + 1) % MOD;
        } else {
            dp1 = (dp0 + dp1 + 1) % MOD;
        }
    }
    return (dp1 + has0) % MOD;
};