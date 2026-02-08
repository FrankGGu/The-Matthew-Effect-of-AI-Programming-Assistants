var construct2DArray = function(original, m, n) {
    if (original.length !== m * n) {
        return [];
    }

    const result = new Array(m).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < original.length; i++) {
        const row = Math.floor(i / n);
        const col = i % n;
        result[row][col] = original[i];
    }

    return result;
};