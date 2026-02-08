var countTriplets = function(arr) {
    let n = arr.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        let xor = 0;
        for (let j = i + 1; j < n; j++) {
            xor ^= arr[j];
            if (xor === 0) {
                count += (j - i);
            }
        }
    }
    return count;
};