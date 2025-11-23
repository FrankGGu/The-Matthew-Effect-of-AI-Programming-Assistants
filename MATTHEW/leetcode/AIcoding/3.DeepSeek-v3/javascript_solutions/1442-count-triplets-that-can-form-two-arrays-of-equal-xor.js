var countTriplets = function(arr) {
    let count = 0;
    const n = arr.length;
    for (let i = 0; i < n; i++) {
        let a = 0;
        for (let j = i + 1; j < n; j++) {
            a ^= arr[j - 1];
            let b = 0;
            for (let k = j; k < n; k++) {
                b ^= arr[k];
                if (a === b) {
                    count++;
                }
            }
        }
    }
    return count;
};