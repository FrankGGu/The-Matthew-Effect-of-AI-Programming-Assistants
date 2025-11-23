var countKSubarrays = function(arr, k) {
    let count = 0;
    let sum = 0;
    let left = 0;

    for (let right = 0; right < arr.length; right++) {
        sum += arr[right];

        while (right - left + 1 > k) {
            sum -= arr[left++];
        }

        if (right - left + 1 === k) {
            count += (sum === k ? 1 : 0);
        }
    }

    return count;
};