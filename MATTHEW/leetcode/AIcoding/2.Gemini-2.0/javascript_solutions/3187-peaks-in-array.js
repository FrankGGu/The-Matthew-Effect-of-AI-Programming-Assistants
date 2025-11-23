var findPeaks = function(arr) {
    const peaks = [];
    for (let i = 1; i < arr.length - 1; i++) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            peaks.push(i);
        }
    }
    return peaks;
};