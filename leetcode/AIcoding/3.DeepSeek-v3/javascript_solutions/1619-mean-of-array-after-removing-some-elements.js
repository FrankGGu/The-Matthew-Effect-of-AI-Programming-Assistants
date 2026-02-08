var trimMean = function(arr) {
    arr.sort((a, b) => a - b);
    const n = arr.length;
    const remove = Math.floor(n * 0.05);
    let sum = 0;
    for (let i = remove; i < n - remove; i++) {
        sum += arr[i];
    }
    return sum / (n - 2 * remove);
};