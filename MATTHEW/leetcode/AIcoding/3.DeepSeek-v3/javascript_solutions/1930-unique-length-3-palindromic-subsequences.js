var countPalindromicSubsequence = function(s) {
    const first = new Array(26).fill(Infinity);
    const last = new Array(26).fill(-1);
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const code = s.charCodeAt(i) - 97;
        first[code] = Math.min(first[code], i);
        last[code] = Math.max(last[code], i);
    }

    let res = 0;
    for (let i = 0; i < 26; i++) {
        if (first[i] < last[i]) {
            const seen = new Set();
            for (let j = first[i] + 1; j < last[i]; j++) {
                seen.add(s[j]);
            }
            res += seen.size;
        }
    }
    return res;
};