function countKSubsequencesWithMaxBeauty(s, k) {
    const freq = new Map();
    for (const char of s) {
        freq.set(char, (freq.get(char) || 0) + 1);
    }
    const counts = Array.from(freq.values()).sort((a, b) => b - a);

    if (counts.length < k) return 0;

    let maxBeauty = 0;
    for (let i = 0; i < k; i++) {
        maxBeauty += counts[i];
    }

    let ways = 1;
    const lastCount = counts[k - 1];
    let lastCountTotal = 0;

    for (const count of counts) {
        if (count === lastCount) lastCountTotal++;
    }

    const lastCountUsed = counts.slice(0, k).filter(c => c === lastCount).length;

    for (let i = 0; i < lastCountUsed; i++) {
        ways *= lastCountTotal - i;
    }

    return ways;
}