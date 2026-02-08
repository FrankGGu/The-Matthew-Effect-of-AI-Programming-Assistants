var threeSumMulti = function(arr, target) {
    const MOD = 1_000_000_007;
    let ans = 0;
    const freq = new Array(101).fill(0);

    for (const x of arr) {
        freq[x]++;
    }

    for (let i = 0; i <= 100; i++) {
        if (freq[i] === 0) continue;

        for (let j = i; j <= 100; j++) {
            if (freq[j] === 0) continue;

            const k = target - i - j;

            if (k < j || k > 100 || freq[k] === 0) {
                continue;
            }

            if (i === j && j === k) {
                // Case 1: i == j == k
                // Choose 3 distinct indices from freq[i] elements
                // C(freq[i], 3) = freq[i] * (freq[i] - 1) * (freq[i] - 2) / 6
                ans = (ans + (freq[i] * (freq[i] - 1) * (freq[i] - 2)) / 6) % MOD;
            } else if (i === j && j !== k) {
                // Case 2: i == j < k
                // Choose 2 distinct indices from freq[i] elements, and 1 from freq[k]
                // C(freq[i], 2) * C(freq[k], 1) = (freq[i] * (freq[i] - 1) / 2) * freq[k]
                ans = (ans + (freq[i] * (freq[i] - 1)) / 2 * freq[k]) % MOD;
            } else if (i < j && j === k) {
                // Case 3: i < j == k
                // Choose 1 from freq[i], and 2 from freq[j]
                // C(freq[i], 1) * C(freq[j], 2) = freq[i] * (freq[j] * (freq[j] - 1) / 2)
                ans = (ans + freq[i] * (freq[j] * (freq[j] - 1)) / 2) % MOD;
            } else { // i < j < k
                // Case 4: i < j < k
                // Choose 1 from freq[i], 1 from freq[j], 1 from freq[k]
                // C(freq[i], 1) * C(freq[j], 1) * C(freq[k], 1) = freq[i] * freq[j] * freq[k]
                ans = (ans + freq[i] * freq[j] * freq[k]) % MOD;
            }
        }
    }

    return ans;
};