function numSubarrays(arr) {
    const n = arr.length;
    let result = 0;
    for (let i = 0; i < n; i++) {
        let maxVal = arr[i];
        for (let j = i; j < n; j++) {
            if (arr[j] > maxVal) {
                maxVal = arr[j];
            }
            if (arr[i] === maxVal && arr[j] === maxVal) {
                result++;
            }
        }
    }
    return result;
}