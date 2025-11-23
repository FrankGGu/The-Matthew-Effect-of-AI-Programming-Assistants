function countPairs(deliciousness) {
    const mod = 1e9 + 7;
    const count = new Map();
    let result = 0;

    for (const num of deliciousness) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    for (const [num, freq] of count.entries()) {
        for (let i = 0; i <= 21; i++) {
            const target = 1 << i;
            if (target > 2 * num) break;
            if (target === num) {
                result = (result + (freq * (freq - 1) / 2) % mod) % mod;
            } else {
                const targetFreq = count.get(target - num) || 0;
                result = (result + (freq * targetFreq) % mod) % mod;
            }
        }
    }

    return result;
}