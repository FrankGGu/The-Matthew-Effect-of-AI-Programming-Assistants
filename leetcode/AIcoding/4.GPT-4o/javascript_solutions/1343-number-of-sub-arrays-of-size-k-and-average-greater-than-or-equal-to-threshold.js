function numOfSubarrays(arr, k, threshold) {
    let count = 0;
    let sum = 0;

    for (let i = 0; i < k; i++) {
        sum += arr[i];
    }

    if (sum / k >= threshold) {
        count++;
    }

    for (let i = k; i < arr.length; i++) {
        sum += arr[i] - arr[i - k];
        if (sum / k >= threshold) {
            count++;
        }
    }

    return count;
}