var maxChunksToSorted = function(arr) {
    const n = arr.length;
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

    let res = 0;
    for (let i = 0; i < n - 1; i++) {
        if (maxLeft[i] <= minRight[i + 1]) {
            res++;
        }
    }

    return res + 1;
};