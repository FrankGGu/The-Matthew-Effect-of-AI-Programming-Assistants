var countUniqueGoodSubsequences = function(binary) {
    const MOD = 1e9 + 7;
    let lastIndex = -1, count = 0, hasZero = false;
    const n = binary.length;

    for (let i = 0; i < n; i++) {
        if (binary[i] === '1') {
            count = (count * 2 + 1) % MOD;
            lastIndex = i;
        } else {
            hasZero = true;
        }
    }

    if (lastIndex === -1) return hasZero ? 1 : 0;

    return (count + (hasZero ? 1 : 0)) % MOD;
};