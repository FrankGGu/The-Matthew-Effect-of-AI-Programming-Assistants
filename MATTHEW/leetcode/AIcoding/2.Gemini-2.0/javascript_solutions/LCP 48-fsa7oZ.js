var isReachable = function(board, start, end) {
    const m = board.length;
    const n = board[0].length;
    const visited = new Set();
    const queue = [[start[0], start[1]]];
    visited.add(start[0] + "," + start[1]);

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col] = queue.shift();

        if (row === end[0] && col === end[1]) {
            return true;
        }

        for (const [dr, dc] of directions) {
            let newRow = row + dr;
            let newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && board[newRow][newCol] === 0) {
                if (!visited.has(newRow + "," + newCol)) {
                    queue.push([newRow, newCol]);
                    visited.add(newRow + "," + newCol);
                }
            }
        }
    }

    return false;
};