var mergeSimilarItems = function(items1, items2) {
    const map = new Map();
    for (const [value, weight] of items1) {
        map.set(value, weight);
    }
    for (const [value, weight] of items2) {
        if (map.has(value)) {
            map.set(value, map.get(value) + weight);
        } else {
            map.set(value, weight);
        }
    }
    const result = [];
    for (const [value, weight] of map) {
        result.push([value, weight]);
    }
    result.sort((a, b) => a[0] - b[0]);
    return result;
};