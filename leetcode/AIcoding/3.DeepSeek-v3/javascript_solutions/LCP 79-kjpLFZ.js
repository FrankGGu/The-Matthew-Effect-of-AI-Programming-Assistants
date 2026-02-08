var isCompliance = function(matrix, path) {
    const rows = matrix.length;
    if (rows === 0) return false;
    const cols = matrix[0].length;

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const dfs = (i, j, index) => {
        if (index === path.length) return true;
        if (i < 0 || i >= rows || j < 0 || j >= cols || matrix[i][j] !== path[index]) {
            return false;
        }

        const temp = matrix[i][j];
        matrix[i] = matrix[i].substring(0, j) + '#' + matrix[i].substring(j + 1);

        for (const [dx, dy] of directions) {
            if (dfs(i + dx, j + dy, index + 1)) {
                return true;
            }
        }

        matrix[i] = matrix[i].substring(0, j) + temp + matrix[i].substring(j + 1);
        return false;
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === path[0]) {
                if (dfs(i, j, 0)) {
                    return true;
                }
            }
        }
    }

    return false;
};