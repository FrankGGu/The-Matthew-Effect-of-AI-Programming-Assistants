var maxChunksToSorted = function(arr) {
    let n = arr.length;
    let maxRight = new Array(n).fill(0);
    let minLeft = new Array(n).fill(0);

    maxRight[0] = arr[0];
    for (let i = 1; i < n; i++) {
        maxRight[i] = Math.max(maxRight[i - 1], arr[i]);
    }

    minLeft[n - 1] = arr[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        minLeft[i] = Math.min(minLeft[i + 1], arr[i]);
    }

    let chunks = 0;
    for (let i = 0; i < n - 1; i++) {
        if (maxRight[i] <= minLeft[i + 1]) {
            chunks++;
        }
    }

    return chunks + 1;
};