function minimumSumOfMountainTriplets(arr) {
    let n = arr.length;
    if (n < 3) return 0;

    let minSum = Infinity;

    for (let i = 1; i < n - 1; i++) {
        for (let j = 0; j < i; j++) {
            for (let k = i + 1; k < n; k++) {
                if (arr[j] < arr[i] && arr[k] < arr[i]) {
                    minSum = Math.min(minSum, arr[j] + arr[i] + arr[k]);
                }
            }
        }
    }

    return minSum === Infinity ? 0 : minSum;
}