function findDiagonalOrder(matrix) {
    if (!matrix || matrix.length === 0) return [];

    const result = [];
    const map = {};

    for (let row = 0; row < matrix.length; row++) {
        for (let col = 0; col < matrix[row].length; col++) {
            const key = row + col;
            if (!map[key]) {
                map[key] = [];
            }
            map[key].push(matrix[row][col]);
        }
    }

    for (const key in map) {
        result.push(...map[key]);
    }

    return result;
}