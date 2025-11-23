function lenLongestFib1(arr) {
    const n = arr.length;
    const dp = new Array(n).fill(0).map(() => new Array(n).fill(2));
    const map = new Map();
    for (let i = 0; i < n; i++) {
        map.set(arr[i], i);
    }
    let maxLen = 2;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const prev = arr[i] - arr[j];
            if (map.has(prev)) {
                const k = map.get(prev);
                if (k < j) {
                    dp[j][i] = dp[k][j] + 1;
                    maxLen = Math.max(maxLen, dp[j][i]);
                }
            }
        }
    }
    return maxLen;
}