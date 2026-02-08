function canTransform(arr) {
    let count = 0;
    const n = arr.length;
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + arr[i];
    }

    for (let i = 0; i < n; i++) {
        if (arr[i] > 0) {
            count += arr[i];
        } else if (arr[i] < 0) {
            count += arr[i];
            if (count < 0) return false;
        }
    }

    return count === 0;
}