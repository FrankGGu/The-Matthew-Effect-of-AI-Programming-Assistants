function arrayRankTransform(arr) {
    const sorted = [...new Set(arr)].sort((a, b) => a - b);
    const rankMap = new Map();
    for (let i = 0; i < sorted.length; i++) {
        rankMap.set(sorted[i], i + 1);
    }
    return arr.map(num => rankMap.get(num));
}