var countTriplets = function(arr) {
    let count = 0;
    const n = arr.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                const a = arr[i] ^ arr[j];
                const b = arr[j] ^ arr[k];
                if (a === b) {
                    count++;
                }
            }
        }
    }
    return count;
};