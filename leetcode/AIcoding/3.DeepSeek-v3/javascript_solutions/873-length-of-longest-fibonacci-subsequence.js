var lenLongestFibSubseq = function(arr) {
    const n = arr.length;
    const index = new Map();
    arr.forEach((num, i) => index.set(num, i));
    const dp = Array.from({ length: n }, () => new Array(n).fill(2));
    let maxLen = 0;

    for (let k = 0; k < n; k++) {
        for (let j = 0; j < k; j++) {
            const diff = arr[k] - arr[j];
            if (diff < arr[j] && index.has(diff)) {
                const i = index.get(diff);
                dp[j][k] = dp[i][j] + 1;
                maxLen = Math.max(maxLen, dp[j][k]);
            }
        }
    }

    return maxLen >= 3 ? maxLen : 0;
};