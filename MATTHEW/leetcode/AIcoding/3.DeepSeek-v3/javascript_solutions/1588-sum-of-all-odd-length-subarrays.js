var sumOddLengthSubarrays = function(arr) {
    let sum = 0;
    const n = arr.length;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j += 2) {
            for (let k = i; k <= j; k++) {
                sum += arr[k];
            }
        }
    }
    return sum;
};