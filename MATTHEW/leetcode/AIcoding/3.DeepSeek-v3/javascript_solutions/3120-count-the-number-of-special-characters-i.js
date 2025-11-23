var numberOfSpecialChars = function(word) {
    const lower = new Set();
    const upper = new Set();
    let count = 0;

    for (const c of word) {
        if (c >= 'a' && c <= 'z') {
            lower.add(c);
        } else if (c >= 'A' && c <= 'Z') {
            upper.add(c);
        }
    }

    for (const c of lower) {
        const upperC = c.toUpperCase();
        if (upper.has(upperC)) {
            count++;
        }
    }

    return count;
};