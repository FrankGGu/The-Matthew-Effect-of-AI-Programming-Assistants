var findLeastNumOfUniqueInts = function(arr, k) {
    const countMap = new Map();
    for (const num of arr) {
        countMap.set(num, (countMap.get(num) || 0) + 1);
    }

    const counts = Array.from(countMap.values()).sort((a, b) => a - b);
    let uniqueCount = counts.length;

    for (const count of counts) {
        if (k >= count) {
            k -= count;
            uniqueCount--;
        } else {
            break;
        }
    }

    return uniqueCount;
};