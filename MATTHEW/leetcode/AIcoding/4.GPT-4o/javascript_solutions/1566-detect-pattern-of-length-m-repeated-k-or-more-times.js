function containsPattern(arr, m, k) {
    const n = arr.length;
    for (let i = 0; i <= n - m * k; i++) {
        let j;
        for (j = 0; j < k; j++) {
            if (!arr.slice(i + j * m, i + (j + 1) * m).every((val, idx) => val === arr[i + idx])) {
                break;
            }
        }
        if (j === k) return true;
    }
    return false;
}