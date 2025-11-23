var flipChess = function(board, flips) {
    const rows = board.length;
    const cols = board[0].length;
    let maxFlipped = 0;

    const isValid = (r, c) => r >= 0 && r < rows && c >= 0 && c < cols;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]];

    for (let i = 0; i < flips.length; i += 2) {
        const row = flips[i];
        const col = flips[i + 1];

        if (board[row][col] === 'X') continue;

        let flippedCount = 0;
        let tempBoard = board.map(row => [...row]);
        tempBoard[row][col] = 'X';

        for (let dir of directions) {
            let r = row + dir[0];
            let c = col + dir[1];
            let toFlip = [];

            while (isValid(r, c) && tempBoard[r][c] === 'O') {
                toFlip.push([r, c]);
                r += dir[0];
                c += dir[1];
            }

            if (isValid(r, c) && tempBoard[r][c] === 'X' && toFlip.length > 0) {
                for (let [flipR, flipC] of toFlip) {
                    tempBoard[flipR][flipC] = 'X';
                    flippedCount++;
                }
            }
        }
        maxFlipped = Math.max(maxFlipped, flippedCount);

    }

    return maxFlipped;
};