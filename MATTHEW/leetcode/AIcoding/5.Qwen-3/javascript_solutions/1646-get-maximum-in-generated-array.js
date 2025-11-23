function getMaximumGenerated(n) {
    if (n === 0) return 0;
    if (n === 1) return 1;

    const arr = new Array(n + 1);
    arr[0] = 0;
    arr[1] = 1;
    let max = 1;

    for (let i = 2; i <= n; i++) {
        if (i % 2 === 0) {
            arr[i] = arr[i / 2];
        } else {
            arr[i] = arr[(i - 1) / 2] + arr[(i + 1) / 2];
        }
        if (arr[i] > max) {
            max = arr[i];
        }
    }

    return max;
}