function countSubstrings(s, k) {
    let count = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        const freq = new Array(26).fill(0);
        let unique = 0;
        for (let j = i; j < n; j++) {
            const c = s[j];
            if (freq[c.charCodeAt(0) - 'a'.charCodeAt(0)] === 0) {
                unique++;
            }
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            if (unique <= k) {
                count++;
            }
        }
    }
    return count;
}