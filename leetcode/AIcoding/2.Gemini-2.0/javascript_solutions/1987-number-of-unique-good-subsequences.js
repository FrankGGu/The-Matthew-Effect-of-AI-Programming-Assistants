var numberOfUniqueGoodSubsequences = function(binary) {
    const MOD = 10 ** 9 + 7;
    let endsWithZero = 0;
    let endsWithOne = 0;
    let hasZero = false;

    for (const bit of binary) {
        if (bit === '0') {
            endsWithZero = (endsWithZero + endsWithOne) % MOD;
            hasZero = true;
        } else {
            endsWithOne = (endsWithZero + endsWithOne + 1) % MOD;
        }
    }

    let result = (endsWithZero + endsWithOne) % MOD;
    if (hasZero) {
        result = (result + 1) % MOD;
    }

    return result;
};