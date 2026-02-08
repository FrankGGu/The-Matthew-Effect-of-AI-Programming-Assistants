const numberOfGoodSubsets = function(A) {
    const mod = 1e9 + 7;
    const count = new Array(31).fill(0);
    for (let num of A) count[num]++;

    const goodSubsetCount = (count[1] > 0 ? count[1] : 0);
    let result = (goodSubsetCount > 0 ? 1 : 0);

    const primeMask = [0, 1 << 0, 1 << 1, 0, 1 << 2, 0, 1 << 3, 0, 1 << 4, 0, 0, 0, 1 << 5, 0, 1 << 6, 0, 1 << 7, 0, 1 << 8, 0, 1 << 9, 0, 0, 0, 1 << 10, 0, 1 << 11, 0, 0, 0, 0, 0];

    const dp = new Array(1 << 12).fill(0);
    dp[0] = 1;

    for (let i = 2; i < 31; i++) {
        if (count[i] === 0) continue;
        const mask = primeMask[i];
        for (let j = (1 << 12) - 1; j >= 0; j--) {
            if ((j & mask) === 0) {
                dp[j | mask] = (dp[j | mask] + dp[j] * count[i]) % mod;
            }
        }
    }

    for (let i = 0; i < dp.length; i++) {
        result = (result + dp[i]) % mod;
    }

    return result - 1;
};