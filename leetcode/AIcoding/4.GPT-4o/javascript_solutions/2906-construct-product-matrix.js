function construct2DArray(original) {
    if (original.length === 0) return [];
    const n = original.length;
    const m = original[0].length;
    if (n % 2 !== 0 || m % 2 !== 0) return [];

    const rows = n / 2;
    const cols = m / 2;
    const result = new Array(rows).fill(0).map(() => new Array(cols).fill(0));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            result[i][j] = original[2 * i][2 * j] * original[2 * i + 1][2 * j] * original[2 * i][2 * j + 1] * original[2 * i + 1][2 * j + 1];
        }
    }

    return result;
}