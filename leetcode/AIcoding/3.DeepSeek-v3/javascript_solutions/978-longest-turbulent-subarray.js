var maxTurbulenceSize = function(arr) {
    let n = arr.length;
    if (n === 1) return 1;
    let maxLen = 1;
    let left = 0;

    for (let right = 1; right < n; right++) {
        let diffBefore = arr[right - 1] - arr[right];
        if (diffBefore === 0) {
            left = right;
        } else if (right === n - 1 || (diffBefore * (arr[right] - arr[right + 1]) >= 0)) {
            maxLen = Math.max(maxLen, right - left + 1);
            left = right;
        }
    }

    return maxLen;
};