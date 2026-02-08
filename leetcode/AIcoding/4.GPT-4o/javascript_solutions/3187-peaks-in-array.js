function countPeaks(arr) {
    let peaks = 0;
    for (let i = 1; i < arr.length - 1; i++) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            peaks++;
        }
    }
    return peaks;
}