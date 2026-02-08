function trimMean(arr) {
    arr.sort((a, b) => a - b);
    const n = arr.length;
    const toRemove = n * 0.05;
    const sum = arr.slice(toRemove, n - toRemove).reduce((acc, val) => acc + val, 0);
    return sum / (n - 2 * toRemove);
}