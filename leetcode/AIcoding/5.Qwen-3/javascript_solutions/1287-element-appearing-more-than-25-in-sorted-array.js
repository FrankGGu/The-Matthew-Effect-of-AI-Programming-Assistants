function findSpecialInteger(arr) {
    const n = arr.length;
    const quarter = n / 4;

    for (let i = 0; i < n; i++) {
        if (i + 1 < n && arr[i] === arr[i + 1] && i + 2 < n && arr[i] === arr[i + 2]) {
            return arr[i];
        }
    }

    return arr[0];
}