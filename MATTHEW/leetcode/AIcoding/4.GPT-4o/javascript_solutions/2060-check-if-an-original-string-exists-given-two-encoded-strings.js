function canFormOriginalString(s, t, encoded) {
    const count = {};

    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }

    for (const char of t) {
        count[char] = (count[char] || 0) + 1;
    }

    for (const char of encoded) {
        if (count[char]) {
            count[char]--;
        } else {
            return false;
        }
    }

    return Object.values(count).every(val => val === 0);
}