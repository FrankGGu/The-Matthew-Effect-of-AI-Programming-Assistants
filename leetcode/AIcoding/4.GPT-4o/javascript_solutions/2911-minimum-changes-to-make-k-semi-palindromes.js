function minChanges(s, k) {
    const n = s.length;
    if (k === 1) return n - new Set(s).size;

    let res = Infinity;

    for (let i = 0; i < n; i++) {
        const freq = new Array(26).fill(0);
        let changes = 0;
        for (let j = i; j < n; j++) {
            const cIndex = s[j].charCodeAt(0) - 'a'.charCodeAt(0);
            freq[cIndex]++;
            changes++;
            if (j % 2 === 1) {
                const half = (j - i + 1) / 2;
                const maxFreq = Math.max(...freq);
                changes = Math.min(changes, half - maxFreq + ((j - i + 1) % 2));
                if (j >= k - 1) {
                    res = Math.min(res, changes);
                }
            }
        }
    }
    return res === Infinity ? -1 : res;
}