function findSubstringInWraproundString(p) {
    const n = p.length;
    const count = new Array(26).fill(0);
    let maxLen = 0;

    for (let i = 0; i < n; i++) {
        if (i > 0 && (p.charCodeAt(i) - p.charCodeAt(i - 1) + 26) % 26 === 1) {
            maxLen++;
        } else {
            maxLen = 1;
        }
        count[p.charCodeAt(i) - 'a'.charCodeAt(0)] = Math.max(count[p.charCodeAt(i) - 'a'.charCodeAt(0)], maxLen);
    }

    return count.reduce((sum, val) => sum + val, 0);
}