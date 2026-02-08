var maxValue = function(n, index, maxSum) {
    let low = 1, high = maxSum;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let sum = mid;
        let left = Math.max(0, mid - index - 1);
        sum += (mid - 1 + left) * (mid - left) / 2;
        let right = Math.max(0, mid - (n - index) - 1);
        sum += (mid - 1 + right) * (mid - right) / 2;
        if (sum - mid >= maxSum) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return high;
};