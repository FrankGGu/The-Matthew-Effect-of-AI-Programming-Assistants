var snakesAndLadders = function(board) {
    const n = board.length;
    const target = n * n;

    // Helper function to convert a square number (1-indexed) to its (row, col) coordinates (0-indexed)
    // based on the boustrophedon pattern.
    const getCoords = (square) => {
        const rFromBottom = Math.floor((square - 1) / n);
        const actualRow = n - 1 - rFromBottom; // 0-indexed row from top

        let actualCol;
        const colInRow = (square - 1) % n;

        if (rFromBottom % 2 === 0) { // Even row from bottom means left-to-right traversal
            actualCol = colInRow;
        } else { // Odd row from bottom means right-to-left traversal
            actualCol = n - 1 - colInRow;
        }
        return [actualRow, actualCol];
    };

    const queue = [[1, 0]]; // [current_square, moves]
    const visited = new Set();
    visited.add(1);

    while (queue.length > 0) {
        const [currentSquare, moves] = queue.shift();

        if (currentSquare === target) {
            return moves;
        }

        // Roll a dice (1 to 6)
        for (let i = 1; i <= 6; i++) {
            let nextSquare = currentSquare + i;

            if (nextSquare > target) {
                continue; // Cannot go beyond the target square
            }

            const [r, c] = getCoords(nextSquare);
            const boardValue = board[r][c];

            if (boardValue !== -1) { // Snake or ladder
                nextSquare = boardValue;
            }

            if (!visited.has(nextSquare)) {
                visited.add(nextSquare);
                queue.push([nextSquare, moves + 1]);
            }
        }
    }

    return -1; // Target not reachable
};