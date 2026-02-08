function largestOutlier(arr) {
    let mean = arr.reduce((a, b) => a + b, 0) / arr.length;
    let outliers = arr.filter(num => Math.abs(num - mean) > 1.5 * standardDeviation(arr));
    return Math.max(...outliers);
}

function standardDeviation(arr) {
    let mean = arr.reduce((a, b) => a + b, 0) / arr.length;
    return Math.sqrt(arr.reduce((sq, num) => sq + Math.pow(num - mean, 2), 0) / arr.length);
}