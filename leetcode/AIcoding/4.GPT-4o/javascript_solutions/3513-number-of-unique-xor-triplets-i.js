var countTriplets = function(arr) {
    const n = arr.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        let xor = 0;
        for (let j = i; j < n; j++) {
            xor ^= arr[j];
            for (let k = 0; k < i; k++) {
                count += (xor ^ arr[k]) === 0 ? 1 : 0;
            }
        }
    }
    return count;
};