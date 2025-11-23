function numberOfSpecialCharacters(word) {
    const count = new Map();
    for (const c of word) {
        count.set(c, (count.get(c) || 0) + 1);
    }
    let result = 0;
    for (const [c, freq] of count.entries()) {
        if (freq >= 2) {
            result++;
        }
    }
    return result;
}