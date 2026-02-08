function canMakePalindromeQueries(s, queries) {
    const n = s.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + (s[i] === 'a' ? 1 : 0);
    }

    const getCharCount = (l, r) => {
        const a = prefix[r + 1] - prefix[l];
        const b = (r - l + 1) - a;
        return [a, b];
    };

    const result = new Array(queries.length).fill(false);
    for (let i = 0; i < queries.length; i++) {
        const [l, r] = queries[i];
        const [a, b] = getCharCount(l, r);
        if ((a % 2 === 0 && b % 2 === 0) || (a % 2 === 1 && b % 2 === 1)) {
            result[i] = true;
        }
    }
    return result;
}