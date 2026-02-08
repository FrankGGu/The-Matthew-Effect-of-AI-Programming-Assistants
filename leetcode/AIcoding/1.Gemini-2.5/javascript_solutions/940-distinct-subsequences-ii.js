var distinctSubseqII = function(s) {
    const MOD = 10**9 + 7;
    const n = s.length;

    const countEndingWith = new Array(26).fill(0);
    let totalDistinctSubsequences = 0;

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);

        const newCountForChar = (1 + totalDistinctSubsequences) % MOD;

        totalDistinctSubsequences = (totalDistinctSubsequences + newCountForChar - countEndingWith[charCode] + MOD) % MOD;

        countEndingWith[charCode] = newCountForChar;
    }

    return totalDistinctSubsequences;
};