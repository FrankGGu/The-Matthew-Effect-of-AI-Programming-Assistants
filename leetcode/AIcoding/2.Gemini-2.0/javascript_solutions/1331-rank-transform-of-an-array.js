var arrayRankTransform = function(arr) {
    const sortedArr = [...new Set(arr)].sort((a, b) => a - b);
    const rankMap = new Map();
    for (let i = 0; i < sortedArr.length; i++) {
        rankMap.set(sortedArr[i], i + 1);
    }
    const result = [];
    for (let num of arr) {
        result.push(rankMap.get(num));
    }
    return result;
};