var mostBeautifulItem = function(items, queries) {
    items.sort((a, b) => a[0] - b[0]);

    const indexedQueries = queries.map((q, i) => [q, i]);
    indexedQueries.sort((a, b) => a[0] - b[0]);

    const ans = new Array(queries.length);
    let maxBeauty = 0;
    let itemIdx = 0;

    for (let i = 0; i < indexedQueries.length; i++) {
        const queryPrice = indexedQueries[i][0];
        const originalIndex = indexedQueries[i][1];

        while (itemIdx < items.length && items[itemIdx][0] <= queryPrice) {
            maxBeauty = Math.max(maxBeauty, items[itemIdx][1]);
            itemIdx++;
        }
        ans[originalIndex] = maxBeauty;
    }

    return ans;
};