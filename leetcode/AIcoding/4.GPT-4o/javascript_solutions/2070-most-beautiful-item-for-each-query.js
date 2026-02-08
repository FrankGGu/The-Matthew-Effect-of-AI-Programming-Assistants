var mostBeautifulItem = function(items, queries) {
    items.sort((a, b) => a[0] - b[0]);
    const prefixSum = new Array(items.length + 1).fill(0);
    for (let i = 1; i <= items.length; i++) {
        prefixSum[i] = prefixSum[i - 1] + items[i - 1][1];
    }

    const results = [];
    for (const query of queries) {
        let left = 0, right = items.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (items[mid][0] <= query) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        results.push(prefixSum[left]);
    }

    return results;
};