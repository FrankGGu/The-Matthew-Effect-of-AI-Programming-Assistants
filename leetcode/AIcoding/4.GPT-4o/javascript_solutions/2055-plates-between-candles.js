var platesBetweenCandles = function(s, queries) {
    const n = s.length;
    const left = new Array(n);
    const right = new Array(n);
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + (s[i] === '*' ? 1 : 0);
        left[i] = s[i] === '|' ? i : (i > 0 ? left[i - 1] : -1);
    }

    for (let i = n - 1; i >= 0; i--) {
        right[i] = s[i] === '|' ? i : (i < n - 1 ? right[i + 1] : -1);
    }

    const result = [];
    for (const [start, end] of queries) {
        const l = right[start];
        const r = left[end];
        if (l === -1 || r === -1 || l >= r) {
            result.push(0);
        } else {
            result.push(prefixSum[r + 1] - prefixSum[l]);
        }
    }

    return result;
};