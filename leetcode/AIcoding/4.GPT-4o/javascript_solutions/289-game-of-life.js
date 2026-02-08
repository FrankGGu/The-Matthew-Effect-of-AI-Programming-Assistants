var gameOfLife = function(board) {
    const directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
    const rows = board.length;
    const cols = board[0].length;

    const countLiveNeighbors = (r, c) => {
        let count = 0;
        for (const [dr, dc] of directions) {
            const newRow = r + dr, newCol = c + dc;
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && (board[newRow][newCol] === 1 || board[newRow][newCol] === -1)) {
                count++;
            }
        }
        return count;
    };

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            const liveNeighbors = countLiveNeighbors(r, c);
            if (board[r][c] === 1 && (liveNeighbors < 2 || liveNeighbors > 3)) {
                board[r][c] = -1;
            }
            if (board[r][c] === 0 && liveNeighbors === 3) {
                board[r][c] = 2;
            }
        }
    }

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (board[r][c] === -1) {
                board[r][c] = 0;
            }
            if (board[r][c] === 2) {
                board[r][c] = 1;
            }
        }
    }
};