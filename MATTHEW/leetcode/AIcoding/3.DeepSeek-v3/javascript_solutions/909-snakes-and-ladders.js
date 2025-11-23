var snakesAndLadders = function(board) {
    const n = board.length;
    const visited = new Array(n * n + 1).fill(false);
    const queue = [[1, 0]]; // [square, moves]
    visited[1] = true;

    while (queue.length > 0) {
        const [current, moves] = queue.shift();
        if (current === n * n) return moves;

        for (let i = 1; i <= 6 && current + i <= n * n; i++) {
            const next = current + i;
            const [row, col] = getPosition(next, n);
            const destination = board[row][col] === -1 ? next : board[row][col];

            if (!visited[destination]) {
                visited[destination] = true;
                queue.push([destination, moves + 1]);
            }
        }
    }

    return -1;
};

function getPosition(num, n) {
    const row = Math.floor((num - 1) / n);
    const col = (num - 1) % n;
    const actualRow = n - 1 - row;
    const actualCol = row % 2 === 0 ? col : n - 1 - col;
    return [actualRow, actualCol];
}