var distinctEchoSubstrings = function(text) {
    const n = text.length;
    const seen = new Set();

    for (let len = 1; len <= n / 2; len++) {
        for (let i = 0; i <= n - 2 * len; i++) {
            const j = i + len;
            const substring = text.substring(i, j);
            const nextSubstring = text.substring(j, j + len);
            if (substring === nextSubstring) {
                seen.add(substring);
            }
        }
    }

    return seen.size;
};