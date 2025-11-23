function countTriplets(arr) {
    const n = arr.length;
    const uniqueTriplets = new Set();

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                const xorValue = arr[i] ^ arr[j] ^ arr[k];
                uniqueTriplets.add(xorValue);
            }
        }
    }

    return uniqueTriplets.size;
}