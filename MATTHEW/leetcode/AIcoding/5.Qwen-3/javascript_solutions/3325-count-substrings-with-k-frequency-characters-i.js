function countKFrequency(s, k) {
    let count = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        const freq = {};
        for (let j = i; j < n; j++) {
            const c = s[j];
            freq[c] = (freq[c] || 0) + 1;
            if (Object.values(freq).every(v => v >= k)) {
                count++;
            }
        }
    }
    return count;
}