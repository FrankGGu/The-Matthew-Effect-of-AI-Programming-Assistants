function transformArray(arr) {
    const n = arr.length;
    const result = [...arr];
    for (let i = 1; i < n - 1; i++) {
        result[i] = arr[i - 1] + arr[i + 1];
    }
    return result;
}