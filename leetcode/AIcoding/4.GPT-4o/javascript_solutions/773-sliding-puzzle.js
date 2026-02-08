var slidingPuzzle = function(board) {
    const target = "123450";
    const start = board.flat().join('');
    const moves = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const rows = 2, cols = 3;

    const isValid = (x, y) => x >= 0 && x < rows && y >= 0 && y < cols;

    const bfs = (start) => {
        const queue = [[start, start.indexOf('0'), 0]];
        const visited = new Set([start]);

        while (queue.length) {
            const [current, zeroIndex, steps] = queue.shift();
            if (current === target) return steps;

            const zeroRow = Math.floor(zeroIndex / cols);
            const zeroCol = zeroIndex % cols;

            for (const [dx, dy] of moves) {
                const newRow = zeroRow + dx, newCol = zeroCol + dy;
                if (isValid(newRow, newCol)) {
                    const newZeroIndex = newRow * cols + newCol;
                    const newBoardArr = current.split('');
                    [newBoardArr[zeroIndex], newBoardArr[newZeroIndex]] = [newBoardArr[newZeroIndex], newBoardArr[zeroIndex]];
                    const newBoard = newBoardArr.join('');

                    if (!visited.has(newBoard)) {
                        visited.add(newBoard);
                        queue.push([newBoard, newZeroIndex, steps + 1]);
                    }
                }
            }
        }
        return -1;
    };

    return bfs(start);
};