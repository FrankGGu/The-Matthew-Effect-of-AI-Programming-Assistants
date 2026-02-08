var countSpecialSubsequences = function(s) {
    const MOD = 10 ** 9 + 7;

    let count1 = 0;
    let count12 = 0;
    let count123 = 0;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === '1') {
            count1 = (2 * count1 + 1) % MOD;
        } else if (char === '2') {
            count12 = (2 * count12 + count1) % MOD;
        } else if (char === '3') {
            count123 = (2 * count123 + count12) % MOD;
        }
    }

    return count123;
};