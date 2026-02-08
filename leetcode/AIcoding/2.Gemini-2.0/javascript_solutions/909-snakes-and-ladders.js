var snakesAndLadders = function(board) {
    const n = board.length;
    const visited = new Array(n * n + 1).fill(false);
    const queue = [[1, 0]];
    visited[1] = true;

    const getCoordinates = (square) => {
        const row = n - 1 - Math.floor((square - 1) / n);
        const col = (n - 1 - row) % 2 === 0 ? (square - 1) % n : n - 1 - (square - 1) % n;
        return [row, col];
    }

    while (queue.length > 0) {
        const [square, moves] = queue.shift();

        if (square === n * n) {
            return moves;
        }

        for (let i = 1; i <= 6; i++) {
            const nextSquare = square + i;
            if (nextSquare > n * n) continue;

            const [row, col] = getCoordinates(nextSquare);
            let destination = board[row][col] === -1 ? nextSquare : board[row][col];

            if (!visited[destination]) {
                visited[destination] = true;
                queue.push([destination, moves + 1]);
            }
        }
    }

    return -1;
};