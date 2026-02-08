function minSubstring(s) {
    const n = s.length;
    let minLen = Infinity;

    for (let len = 1; len <= n; len++) {
        for (let start = 0; start <= n - len; start++) {
            const substring = s.slice(start, start + len);
            const count = {};

            for (const char of substring) {
                count[char] = (count[char] || 0) + 1;
            }

            const values = Object.values(count);
            if (values.every(v => v === values[0])) {
                minLen = Math.min(minLen, len);
            }
        }
    }

    return minLen === Infinity ? 0 : minLen;
}