function xSum(arr, k) {
    let n = arr.length;
    let result = 0;
    let currentSum = 0;

    for (let i = 0; i < n; i++) {
        currentSum += arr[i];
        if (i >= k) {
            currentSum -= arr[i - k];
        }
        if (i >= k - 1) {
            result += currentSum;
        }
    }

    return result;
}