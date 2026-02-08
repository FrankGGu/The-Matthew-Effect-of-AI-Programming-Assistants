var findSubarrayWithBitwiseORClosestToK = function(arr, k) {
    let n = arr.length;
    let minDiff = Infinity;
    let result = 0;

    for (let i = 0; i < n; i++) {
        let currentOr = 0;
        for (let j = i; j < n; j++) {
            currentOr |= arr[j];
            let diff = Math.abs(currentOr - k);
            if (diff < minDiff) {
                minDiff = diff;
                result = currentOr;
            } else if (diff === minDiff && currentOr < result) {
                 result = currentOr;
            }
        }
    }

    return result;
};