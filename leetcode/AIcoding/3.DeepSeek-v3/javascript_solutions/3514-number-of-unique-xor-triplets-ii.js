var countTriplets = function(arr) {
    let count = 0;
    const n = arr.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] ^ arr[i];
    }
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j; k < n; k++) {
                const a = prefix[j] ^ prefix[i];
                const b = prefix[k + 1] ^ prefix[j];
                if (a === b) {
                    count++;
                }
            }
        }
    }
    return count;
};