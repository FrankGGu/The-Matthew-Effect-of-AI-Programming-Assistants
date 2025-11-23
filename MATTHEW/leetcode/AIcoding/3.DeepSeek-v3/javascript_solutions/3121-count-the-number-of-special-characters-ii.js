var numberOfSpecialChars = function(word) {
    const lower = new Set();
    const upper = new Set();
    const special = new Set();

    for (const c of word) {
        if (c >= 'a' && c <= 'z') {
            lower.add(c);
            if (upper.has(c.toUpperCase())) {
                special.add(c);
            }
        } else if (c >= 'A' && c <= 'Z') {
            upper.add(c);
            if (lower.has(c.toLowerCase())) {
                special.add(c.toLowerCase());
            }
        }
    }

    return special.size;
};