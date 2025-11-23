function countKSubsequencesWithMaxBeauty(s, k) {
    const MOD = 10 ** 9 + 7;
    const freq = Array(26).fill(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    const counts = [];
    for (let i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            counts.push(freq[i]);
        }
    }
    counts.sort((a, b) => b - a);
    let total = 0;
    let maxFreq = 0;
    for (let i = 0; i < counts.length; i++) {
        if (i < k) {
            total += counts[i];
            maxFreq = counts[i];
        } else {
            break;
        }
    }
    if (total < k) return 0;
    let res = 1;
    let cnt = 0;
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] === maxFreq) {
            cnt++;
        }
    }
    let ways = 1;
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] === maxFreq) {
            ways = ways * (cnt--) % MOD;
        }
    }
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] > maxFreq) {
            res = res * counts[i] % MOD;
        }
    }
    return res * ways % MOD;
}