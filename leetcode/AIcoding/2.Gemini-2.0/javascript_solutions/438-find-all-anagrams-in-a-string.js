var findAnagrams = function(s, p) {
    const n = s.length;
    const m = p.length;
    if (m > n) return [];

    const pCount = new Array(26).fill(0);
    const sCount = new Array(26).fill(0);

    for (let i = 0; i < m; i++) {
        pCount[p.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        sCount[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const result = [];
    if (pCount.every((val, idx) => val === sCount[idx])) {
        result.push(0);
    }

    for (let i = m; i < n; i++) {
        sCount[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        sCount[s.charCodeAt(i - m) - 'a'.charCodeAt(0)]--;

        if (pCount.every((val, idx) => val === sCount[idx])) {
            result.push(i - m + 1);
        }
    }

    return result;
};