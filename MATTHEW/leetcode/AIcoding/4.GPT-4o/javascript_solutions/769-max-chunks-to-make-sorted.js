var maxChunksToSorted = function(arr) {
    let sum = 0, max = 0, chunks = 0;
    for (let i = 0; i < arr.length; i++) {
        sum += arr[i];
        max = Math.max(max, arr[i]);
        if (sum === max * (chunks + 1)) {
            chunks++;
        }
    }
    return chunks;
};