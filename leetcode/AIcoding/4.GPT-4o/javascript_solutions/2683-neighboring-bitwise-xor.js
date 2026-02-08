function findNeighboringXOR(arr) {
    const n = arr.length;
    const result = new Array(n);
    for (let i = 0; i < n; i++) {
        const left = i > 0 ? arr[i - 1] : 0;
        const right = i < n - 1 ? arr[i + 1] : 0;
        result[i] = left ^ right;
    }
    return result;
}