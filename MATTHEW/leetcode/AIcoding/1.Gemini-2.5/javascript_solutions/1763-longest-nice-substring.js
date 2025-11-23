var longestNiceSubstring = function(s) {
    const n = s.length;
    if (n < 2) {
        return "";
    }

    const seenChars = new Set();
    for (let i = 0; i < n; i++) {
        seenChars.add(s[i]);
    }

    for (let i = 0; i < n; i++) {
        const char = s[i];
        const lower = char.toLowerCase();
        const upper = char.toUpperCase();

        if (!seenChars.has(lower) || !seenChars.has(upper)) {
            const s1 = longestNiceSubstring(s.substring(0, i));
            const s2 = longestNiceSubstring(s.substring(i + 1));

            if (s1.length >= s2.length) {
                return s1;
            } else {
                return s2;
            }
        }
    }

    return s;
};