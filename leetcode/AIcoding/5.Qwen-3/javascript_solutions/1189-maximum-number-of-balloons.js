function maxNumberOfBalloons(text) {
    const count = {};
    for (const char of text) {
        count[char] = (count[char] || 0) + 1;
    }

    const required = { 'b': 1, 'a': 1, 'l': 2, 'o': 2, 'n': 1 };
    let min = Infinity;

    for (const key in required) {
        if (!count[key]) return 0;
        min = Math.min(min, Math.floor(count[key] / required[key]));
    }

    return min;
}