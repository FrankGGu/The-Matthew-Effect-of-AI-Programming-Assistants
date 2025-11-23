function countIncremovableSubarrays(arr) {
    const n = arr.length;
    let left = new Array(n).fill(1);
    let right = new Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        if (arr[i] >= arr[i - 1]) {
            left[i] = left[i - 1] + 1;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (arr[i] <= arr[i + 1]) {
            right[i] = right[i + 1] + 1;
        }
    }

    let total = 0;
    for (let i = 0; i < n; i++) {
        total += left[i] + right[i] - 1;
    }

    let maxSubarray = Math.max(...left);
    let minSubarray = Math.min(...right);

    for (let i = 1; i < n - 1; i++) {
        if (arr[i - 1] < arr[i + 1]) {
            total = Math.max(total, left[i - 1] + right[i + 1]);
        }
    }

    return total - (maxSubarray - 1);
}