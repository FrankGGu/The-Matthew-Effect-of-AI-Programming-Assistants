var numSub = function(s) {
    let totalSubstrings = 0;
    let currentConsecutiveOnes = 0;
    const MOD = 10 ** 9 + 7;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            currentConsecutiveOnes++;
            totalSubstrings = (totalSubstrings + currentConsecutiveOnes) % MOD;
        } else {
            currentConsecutiveOnes = 0;
        }
    }

    return totalSubstrings;
};