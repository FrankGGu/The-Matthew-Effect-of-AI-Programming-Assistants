var maximumBeauty = function(items, queries) {
    items.sort((a, b) => a[0] - b[0]);
    const n = items.length;
    const m = queries.length;
    const maxBeauty = new Array(n);
    maxBeauty[0] = items[0][1];
    for (let i = 1; i < n; i++) {
        maxBeauty[i] = Math.max(maxBeauty[i - 1], items[i][1]);
    }

    const result = new Array(m);
    for (let i = 0; i < m; i++) {
        let left = 0;
        let right = n - 1;
        let ans = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (items[mid][0] <= queries[i]) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (ans === -1) {
            result[i] = 0;
        } else {
            result[i] = maxBeauty[ans];
        }
    }

    return result;
};