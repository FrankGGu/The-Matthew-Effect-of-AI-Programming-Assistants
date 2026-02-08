function findMinimumOperations(arr) {
    const n = arr.length;
    if (n <= 1) return 0;

    let prev = arr[0];
    let count = 0;

    for (let i = 1; i < n; i++) {
        if (arr[i] > prev) {
            prev = arr[i];
        } else {
            count++;
            prev = arr[i] + 1;
        }
    }

    return count;
}