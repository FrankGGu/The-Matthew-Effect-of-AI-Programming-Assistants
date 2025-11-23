function maximumBeauty(items, queries) {
    const n = items.length;
    items.sort((a, b) => a[0] - b[0]);
    const dp = new Array(n);
    dp[0] = items[0][1];

    for (let i = 1; i < n; i++) {
        dp[i] = Math.max(dp[i - 1], items[i][1]);
    }

    const result = [];
    for (const query of queries) {
        let maxBeauty = 0;
        let left = 0, right = n - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (items[mid][0] <= query) {
                maxBeauty = dp[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result.push(maxBeauty);
    }
    return result;
}