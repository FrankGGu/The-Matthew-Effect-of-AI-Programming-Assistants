var numOfSubarrays = function(arr, k, threshold) {
    let sum = 0;
    let count = 0;
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
};