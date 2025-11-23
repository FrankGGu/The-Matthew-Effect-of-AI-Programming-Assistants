var trimMean = function(arr) {
    arr.sort((a, b) => a - b);
    let n = arr.length;
    let drop = Math.floor(n * 0.05);
    let sum = 0;
    for (let i = drop; i < n - drop; i++) {
        sum += arr[i];
    }
    return sum / (n - 2 * drop);
};