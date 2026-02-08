var countPairs = function(delays, n) {
    let count = 0;
    const mod = 1e9 + 7;
    const freq = new Array(n + 1).fill(0);

    for (let delay of delays) {
        freq[delay]++;
    }

    for (let i = 0; i < freq.length; i++) {
        for (let j = i; j < freq.length; j++) {
            if (i + j <= n) {
                if (i === j) {
                    count = (count + (freq[i] * (freq[i] - 1) / 2)) % mod) % mod;
                } else {
                    count = (count + (freq[i] * freq[j]) % mod) % mod;
                }
            }
        }
    }

    return count;
};