function maxSumObtained(nums) {
    const MOD = 1000000007;
    const freq = new Array(21).fill(0);
    for (const num of nums) {
        freq[num]++;
    }
    let result = 0;
    let count = 0;
    for (let i = 20; i >= 0; i--) {
        if (freq[i] > 0) {
            count += freq[i];
            result = (result + i * count) % MOD;
        }
    }
    return result;
}