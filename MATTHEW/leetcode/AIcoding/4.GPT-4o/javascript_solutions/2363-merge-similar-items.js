var mergeSimilarItems = function(items1, items2) {
    const itemMap = new Map();

    for (const [value, weight] of items1) {
        itemMap.set(value, (itemMap.get(value) || 0) + weight);
    }

    for (const [value, weight] of items2) {
        itemMap.set(value, (itemMap.get(value) || 0) + weight);
    }

    return Array.from(itemMap.entries()).sort((a, b) => a[0] - b[0]);
};