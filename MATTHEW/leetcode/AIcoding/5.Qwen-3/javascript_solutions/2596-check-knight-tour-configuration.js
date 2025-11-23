function tourOfKnight(moves, row, column) {
    const directions = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]];
    const n = moves.length;
    const board = Array.from({ length: 8 }, () => Array(8).fill(-1));
    board[row][column] = 0;

    function dfs(x, y, step) {
        if (step === n) return true;
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < 8 && ny >= 0 && ny < 8 && board[nx][ny] === -1) {
                board[nx][ny] = step;
                if (dfs(nx, ny, step + 1)) return true;
                board[nx][ny] = -1;
            }
        }
        return false;
    }

    dfs(row, column, 1);
    return board;
}