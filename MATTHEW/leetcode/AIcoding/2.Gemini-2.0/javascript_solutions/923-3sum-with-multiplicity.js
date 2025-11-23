var threeSumMulti = function(arr, target) {
    const MOD = 1000000007;
    let count = 0;
    const freq = new Array(101).fill(0);
    for (const num of arr) {
        freq[num]++;
    }

    for (let i = 0; i <= 100; i++) {
        for (let j = i; j <= 100; j++) {
            let k = target - i - j;
            if (k < 0 || k > 100) continue;

            if (i === j && j === k) {
                count = (count + (freq[i] * (freq[i] - 1) * (freq[i] - 2) / 6)) % MOD;
            } else if (i === j && j !== k) {
                count = (count + (freq[i] * (freq[i] - 1) / 2 * freq[k])) % MOD;
            } else if (i < j && j < k) {
                count = (count + (freq[i] * freq[j] * freq[k])) % MOD;
            }
        }
    }

    return count;
};