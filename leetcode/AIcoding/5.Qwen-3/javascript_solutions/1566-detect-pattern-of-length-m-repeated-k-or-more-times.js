function containsPattern(arr, m, k) {
    const n = arr.length;
    const requiredLength = m * k;
    for (let i = 0; i <= n - requiredLength; i++) {
        let valid = true;
        for (let j = 0; j < k; j++) {
            for (let p = 0; p < m; p++) {
                if (arr[i + j * m + p] !== arr[i + p]) {
                    valid = false;
                    break;
                }
            }
            if (!valid) break;
        }
        if (valid) return true;
    }
    return false;
}