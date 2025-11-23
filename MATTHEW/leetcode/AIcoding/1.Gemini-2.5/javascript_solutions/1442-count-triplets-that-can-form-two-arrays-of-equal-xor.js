var countTriplets = function(arr) {
    let n = arr.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        let currentXor = 0;
        for (let k = i; k < n; k++) {
            currentXor ^= arr[k];
            if (currentXor === 0) {
                // If the XOR sum from arr[i] to arr[k] (inclusive) is 0,
                // it means arr[i] ^ ... ^ arr[j-1] == arr[j] ^ ... ^ arr[k]
                // for any j such that i < j <= k.
                // The number of such valid 'j' values is (k - i).
                count += (k - i);
            }
        }
    }

    return count;
};