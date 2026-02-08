var trimMean = function(arr) {
    arr.sort((a, b) => a - b);
    const n = arr.length;
    const removeCount = n * 0.05;
    let sum = 0;
    for (let i = removeCount; i < n - removeCount; i++) {
        sum += arr[i];
    }
    return sum / (n - 2 * removeCount);
};