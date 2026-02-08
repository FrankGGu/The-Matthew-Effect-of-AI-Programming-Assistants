var maxChunksToSorted = function(arr) {
    const n = arr.length;
    const minRight = new Array(n);
    minRight[n - 1] = arr[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        minRight[i] = Math.min(minRight[i + 1], arr[i]);
    }

    let maxLeft = arr[0];
    let count = 1;
    for (let i = 0; i < n - 1; i++) {
        maxLeft = Math.max(maxLeft, arr[i]);
        if (maxLeft <= minRight[i + 1]) {
            count++;
        }
    }
    return count;
};