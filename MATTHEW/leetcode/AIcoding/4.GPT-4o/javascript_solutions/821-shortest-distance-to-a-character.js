var shortestToChar = function(s, c) {
    const n = s.length;
    const result = new Array(n);
    let lastPosition = -Infinity;

    for (let i = 0; i < n; i++) {
        if (s[i] === c) {
            lastPosition = i;
        }
        result[i] = i - lastPosition;
    }

    lastPosition = Infinity;
    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === c) {
            lastPosition = i;
        }
        result[i] = Math.min(result[i], lastPosition - i);
    }

    return result;
};