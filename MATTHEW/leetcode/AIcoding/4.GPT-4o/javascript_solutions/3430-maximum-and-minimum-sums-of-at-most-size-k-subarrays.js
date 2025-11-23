function maxAndMinSums(arr, k) {
    const n = arr.length;
    let maxSums = new Array(n - k + 1).fill(0);
    let minSums = new Array(n - k + 1).fill(0);

    let maxDeque = [];
    let minDeque = [];

    for (let i = 0; i < n; i++) {
        if (maxDeque.length && maxDeque[0] <= i - k) {
            maxDeque.shift();
        }
        while (maxDeque.length && arr[maxDeque[maxDeque.length - 1]] <= arr[i]) {
            maxDeque.pop();
        }
        maxDeque.push(i);

        if (minDeque.length && minDeque[0] <= i - k) {
            minDeque.shift();
        }
        while (minDeque.length && arr[minDeque[minDeque.length - 1]] >= arr[i]) {
            minDeque.pop();
        }
        minDeque.push(i);

        if (i >= k - 1) {
            maxSums[i - k + 1] = arr[maxDeque[0]];
            minSums[i - k + 1] = arr[minDeque[0]];
        }
    }

    return {
        maxSum: Math.max(...maxSums),
        minSum: Math.min(...minSums)
    };
}