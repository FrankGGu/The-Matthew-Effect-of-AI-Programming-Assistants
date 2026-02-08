var generateStrings = function(n) {
    const MOD = 1000000007;
    let zeros = 1;
    let ones = 1;

    for (let i = 1; i < n; i++) {
        let newOnes = (ones + zeros) % MOD;
        let newZeros = ones;

        ones = newOnes;
        zeros = newZeros;
    }

    return (ones + zeros) % MOD;
};