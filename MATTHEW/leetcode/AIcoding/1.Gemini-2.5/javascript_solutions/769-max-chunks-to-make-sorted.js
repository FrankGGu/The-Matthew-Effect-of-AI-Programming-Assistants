var maxChunksToSorted = function(arr) {
    let chunks = 0;
    let currentMax = 0;

    for (let i = 0; i < arr.length; i++) {
        currentMax = Math.max(currentMax, arr[i]);
        if (currentMax === i) {
            chunks++;
        }
    }

    return chunks;
};