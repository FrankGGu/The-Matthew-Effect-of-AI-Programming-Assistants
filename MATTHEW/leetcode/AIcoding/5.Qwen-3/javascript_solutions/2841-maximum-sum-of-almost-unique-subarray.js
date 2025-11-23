function maxSumSubarray(arr) {
    const n = arr.length;
    let left = 0;
    let sum = 0;
    let maxSum = 0;
    const freq = {};

    for (let right = 0; right < n; right++) {
        sum += arr[right];
        freq[arr[right]] = (freq[arr[right]] || 0) + 1;

        while (freq[arr[right]] > 1) {
            sum -= arr[left];
            freq[arr[left]]--;
            if (freq[arr[left]] === 0) delete freq[arr[left]];
            left++;
        }

        maxSum = Math.max(maxSum, sum);
    }

    return maxSum;
}