var decrypt = function(code, k) {
    const n = code.length;
    const result = new Array(n).fill(0);
    if (k === 0) {
        return result;
    }
    for (let i = 0; i < n; i++) {
        let sum = 0;
        if (k > 0) {
            for (let j = 1; j <= k; j++) {
                sum += code[(i + j) % n];
            }
        } else {
            for (let j = 1; j <= -k; j++) {
                sum += code[(i - j + n) % n];
            }
        }
        result[i] = sum;
    }
    return result;
};