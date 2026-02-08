var rotate = function(matrix) {
    const n = matrix.length;
    for (let layer = 0; layer < n / 2; layer++) {
        const first = layer;
        const last = n - layer - 1;
        for (let i = first; i < last; i++) {
            const offset = i - first;
            const top = matrix[first][i];
            matrix[first][i] = matrix[last - offset][first];
            matrix[last - offset][first] = matrix[last][last - offset];
            matrix[last][last - offset] = matrix[i][last];
            matrix[i][last] = top;
        }
    }
};