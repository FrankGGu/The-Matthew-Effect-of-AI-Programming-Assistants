var makeArrayIncreasing = function(arr1, arr2) {
    const arr2Sorted = Array.from(new Set(arr2)).sort((a, b) => a - b);
    const n = arr1.length;
    const m = arr2Sorted.length;

    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = -Infinity;

    for (let i = 0; i < n; i++) {
        const nextDp = new Array(n + 1).fill(Infinity);
        for (let j = 0; j <= i; j++) {
            if (dp[j] < arr1[i]) {
                nextDp[j] = Math.min(nextDp[j], arr1[i]);
            }
            const idx = binarySearch(arr2Sorted, dp[j]);
            if (idx < m) {
                nextDp[j + 1] = Math.min(nextDp[j + 1], arr2Sorted[idx]);
            }
        }
        dp.splice(0, n + 1, ...nextDp);
    }

    for (let i = 0; i <= n; i++) {
        if (dp[i] < Infinity) {
            return i;
        }
    }
    return -1;
};

function binarySearch(arr, target) {
    let left = 0, right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}