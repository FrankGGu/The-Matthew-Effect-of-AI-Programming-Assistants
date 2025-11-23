var sumOddLengthSubarrays = function(arr) {
    let totalSum = 0;
    const n = arr.length;

    for (let length = 1; length <= n; length += 2) {
        for (let start = 0; start <= n - length; start++) {
            for (let i = start; i < start + length; i++) {
                totalSum += arr[i];
            }
        }
    }

    return totalSum;
};