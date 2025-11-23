function findOriginalArray(arr) {
    const n = arr.length;
    const original = new Array(n);
    original[0] = arr[0];
    for (let i = 1; i < n; i++) {
        original[i] = arr[i] ^ arr[i - 1];
    }
    return original;
}