var findDiagonalOrder = function(matrix) {
    if (!matrix.length) return [];
    const rows = matrix.length, cols = matrix[0].length;
    const result = [];
    let r = 0, c = 0, dir = 1;

    while (r < rows && c < cols) {
        result.push(matrix[r][c]);
        r -= dir;
        c += dir;
        if (r < 0 || r === rows) {
            if (c >= cols) {
                r += 1;
                c -= 1;
            }
            r += (r < 0) ? 1 : 0;
            c += (c === cols) ? -1 : 0;
            dir = -dir;
        }
    }
    return result;
};