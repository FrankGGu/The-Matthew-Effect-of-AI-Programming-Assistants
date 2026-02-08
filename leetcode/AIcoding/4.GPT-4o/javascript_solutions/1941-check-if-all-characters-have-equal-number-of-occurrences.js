function areOccurrencesEqual(s) {
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    const values = Object.values(count);
    return values.every(v => v === values[0]);
}