var sumOddLengthSubarrays = function(arr) {
    let total = 0;
    const n = arr.length;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j += 2) {
            for (let k = i; k <= j; k++) {
                total += arr[k];
            }
        }
    }
    return total;
};