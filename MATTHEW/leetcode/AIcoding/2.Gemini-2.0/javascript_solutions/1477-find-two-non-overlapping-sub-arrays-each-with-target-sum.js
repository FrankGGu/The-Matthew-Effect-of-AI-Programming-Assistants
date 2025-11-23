var minSumOfLengths = function(arr, target) {
    const n = arr.length;
    const left = new Array(n).fill(Infinity);
    const right = new Array(n).fill(Infinity);
    let sum = 0;
    let start = 0;
    for (let i = 0; i < n; i++) {
        sum += arr[i];
        while (sum > target) {
            sum -= arr[start];
            start++;
        }
        if (sum === target) {
            left[i] = i - start + 1;
            if (i > 0) {
                left[i] = Math.min(left[i], left[i - 1]);
            }
        } else {
            if (i > 0) {
                left[i] = left[i - 1];
            }
        }
    }
    sum = 0;
    start = n - 1;
    for (let i = n - 1; i >= 0; i--) {
        sum += arr[i];
        while (sum > target) {
            sum -= arr[start];
            start--;
        }
        if (sum === target) {
            right[i] = start - i + 1;
            if (i < n - 1) {
                right[i] = Math.min(right[i], right[i + 1]);
            }
        } else {
            if (i < n - 1) {
                right[i] = right[i + 1];
            }
        }
    }
    let minSum = Infinity;
    for (let i = 0; i < n - 1; i++) {
        minSum = Math.min(minSum, left[i] + right[i + 1]);
    }
    return minSum === Infinity ? -1 : minSum;
};