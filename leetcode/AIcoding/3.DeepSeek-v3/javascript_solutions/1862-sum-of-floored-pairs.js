var sumOfFlooredPairs = function(nums) {
    const MOD = 1e9 + 7;
    const maxNum = Math.max(...nums);
    const freq = new Array(maxNum + 1).fill(0);
    const prefix = new Array(maxNum + 1).fill(0);

    for (const num of nums) {
        freq[num]++;
    }

    for (let i = 1; i <= maxNum; i++) {
        prefix[i] = prefix[i - 1] + freq[i];
    }

    let res = 0;
    for (let y = 1; y <= maxNum; y++) {
        if (freq[y] === 0) continue;
        for (let d = 1; d * y <= maxNum; d++) {
            const lower = d * y;
            const upper = (d + 1) * y - 1;
            const upperBound = Math.min(upper, maxNum);
            const count = prefix[upperBound] - prefix[lower - 1];
            res = (res + count * d * freq[y]) % MOD;
        }
    }

    return res;
};