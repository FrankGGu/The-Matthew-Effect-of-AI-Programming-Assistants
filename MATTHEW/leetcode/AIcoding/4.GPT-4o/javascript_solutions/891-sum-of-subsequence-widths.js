var sumSubseqWidths = function(A) {
    const mod = 1e9 + 7;
    const n = A.length;
    A.sort((a, b) => a - b);
    let result = 0;
    let pow2 = 1;

    for (let i = 0; i < n; i++) {
        result = (result + (A[i] * pow2) % mod - (A[n - 1 - i] * pow2) % mod + mod) % mod;
        pow2 = (pow2 * 2) % mod;
    }

    return result;
};