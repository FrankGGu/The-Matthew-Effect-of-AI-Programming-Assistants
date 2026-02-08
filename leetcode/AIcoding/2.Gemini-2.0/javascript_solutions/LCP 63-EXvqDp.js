var findBall = function(board) {
    const m = board.length;
    const n = board[0].length;
    const result = [];

    for (let startCol = 0; startCol < n; startCol++) {
        let currentCol = startCol;
        let currentRow = 0;

        while (currentRow < m) {
            const direction = board[currentRow][currentCol];

            if (direction === 1) {
                if (currentCol === n - 1 || board[currentRow][currentCol + 1] === -1) {
                    currentCol = -1;
                    break;
                } else {
                    currentCol++;
                }
            } else {
                if (currentCol === 0 || board[currentRow][currentCol - 1] === 1) {
                    currentCol = -1;
                    break;
                } else {
                    currentCol--;
                }
            }
            currentRow++;
        }

        result.push(currentCol);
    }

    return result;
};