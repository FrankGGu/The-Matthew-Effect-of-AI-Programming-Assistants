var arrayRankTransform = function(arr) {
    if (arr.length === 0) {
        return [];
    }

    const sortedUnique = Array.from(new Set(arr)).sort((a, b) => a - b);
    const rankMap = new Map();
    for (let i = 0; i < sortedUnique.length; i++) {
        rankMap.set(sortedUnique[i], i + 1);
    }

    const result = new Array(arr.length);
    for (let i = 0; i < arr.length; i++) {
        result[i] = rankMap.get(arr[i]);
    }

    return result;
};