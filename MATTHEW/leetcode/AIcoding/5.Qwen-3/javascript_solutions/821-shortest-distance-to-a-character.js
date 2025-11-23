function shortestToChar(s, c) {
    const n = s.length;
    const result = new Array(n).fill(n);

    let prev = -n;
    for (let i = 0; i < n; i++) {
        if (s[i] === c) {
            prev = i;
        }
        result[i] = Math.min(result[i], i - prev);
    }

    prev = 2 * n;
    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === c) {
            prev = i;
        }
        result[i] = Math.min(result[i], prev - i);
    }

    return result;
}