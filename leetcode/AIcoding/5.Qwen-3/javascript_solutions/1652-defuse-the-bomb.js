function decrypt(code, k) {
    const n = code.length;
    const result = new Array(n).fill(0);

    if (k === 0) {
        return result;
    }

    for (let i = 0; i < n; i++) {
        let sum = 0;
        for (let j = 1; j <= Math.abs(k); j++) {
            let nextIndex = (i + (k > 0 ? j : -j) + n) % n;
            sum += code[nextIndex];
        }
        result[i] = sum;
    }

    return result;
}