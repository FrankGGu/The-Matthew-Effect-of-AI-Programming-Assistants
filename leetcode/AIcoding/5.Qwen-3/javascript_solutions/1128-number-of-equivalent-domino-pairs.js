function numEquivDominoPairs(dominoes) {
    const count = {};
    let result = 0;

    for (const [a, b] of dominoes) {
        const key = a < b ? `${a},${b}` : `${b},${a}`;
        count[key] = (count[key] || 0) + 1;
    }

    for (const key in count) {
        const n = count[key];
        result += n * (n - 1) / 2;
    }

    return result;
}