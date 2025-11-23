function maxMinSubarraySums(arr, k) {
    const n = arr.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + arr[i];
    }

    let maxSum = -Infinity;
    let minSum = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j <= Math.min(i + k, n); j++) {
            const sum = prefix[j] - prefix[i];
            if (sum > maxSum) maxSum = sum;
            if (sum < minSum) minSum = sum;
        }
    }

    return [maxSum, minSum];
}