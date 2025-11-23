var countIncremovableSubarrays = function(arr) {
    const n = arr.length;
    let left = new Array(n).fill(0);
    let right = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (i === 0 || arr[i] >= arr[i - 1]) {
            left[i] = (i === 0 ? 0 : left[i - 1]) + 1;
        } else {
            left[i] = 1;
        }
    }

    for (let i = n - 1; i >= 0; i--) {
        if (i === n - 1 || arr[i] <= arr[i + 1]) {
            right[i] = (i === n - 1 ? 0 : right[i + 1]) + 1;
        } else {
            right[i] = 1;
        }
    }

    let total = 0;
    for (let i = 0; i < n; i++) {
        total += left[i] + right[i] - 1;
    }

    return total - n;
};