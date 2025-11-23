function maximumBeauty(items, queries) {
    items.sort((a, b) => a[0] - b[0]);
    const sortedPrices = items.map(item => item[0]);
    const maxBeauties = [];
    let maxBeauty = 0;
    for (const [price, beauty] of items) {
        maxBeauty = Math.max(maxBeauty, beauty);
        maxBeauties.push(maxBeauty);
    }
    const result = [];
    for (const query of queries) {
        let left = 0, right = items.length - 1;
        let best = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (items[mid][0] <= query) {
                best = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        if (best !== -1) {
            result.push(maxBeauties[best]);
        } else {
            result.push(0);
        }
    }
    return result;
}