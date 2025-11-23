var maxChunksToSorted = function(arr) {
    const n = arr.length;
    if (n === 0) {
        return 0;
    }

    const maxLeft = new Array(n);
    const minRight = new Array(n);

    maxLeft[0] = arr[0];
    for (let i = 1; i < n; i++) {
        maxLeft[i] = Math.max(maxLeft[i - 1], arr[i]);
    }

    minRight[n - 1] = arr[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        minRight[i] = Math.min(minRight[i + 1], arr[i]);
    }

    let chunks = 0;
    for (let i = 0; i < n - 1; i++) {
        if (maxLeft[i] <= minRight[i + 1]) {
            chunks++;
        }
    }

    return chunks + 1;
};