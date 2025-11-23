var solve = function(board, playerColor) {
    const m = board.length;
    const n = board[0].length;

    const dr = [-1, -1, -1, 0, 0, 1, 1, 1];
    const dc = [-1, 0, 1, -1, 1, -1, 0, 1];

    const opponentColor = (playerColor === 'W') ? 'B' : 'W';

    let maxTotalFlips = 0;

    const calculateFlipsForMove = (r, c) => {
        let currentMoveFlips = 0;
        for (let i = 0; i < 8; i++) {
            let flipsInDirection = 0;
            let tempR = r + dr[i];
            let tempC = c + dc[i];

            while (tempR >= 0 && tempR < m && tempC >= 0 && tempC < n && board[tempR][tempC] === opponentColor) {
                flipsInDirection++;
                tempR += dr[i];
                tempC += dc[i];
            }

            if (flipsInDirection > 0 && tempR >= 0 && tempR < m && tempC >= 0 && tempC < n && board[tempR][tempC] === playerColor) {
                currentMoveFlips += flipsInDirection;
            }
        }
        return currentMoveFlips;
    };

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (board[r][c] === '.') {
                const flips = calculateFlipsForMove(r, c);
                if (flips > 0) {
                    maxTotalFlips = Math.max(maxTotalFlips, flips);
                }
            }
        }
    }

    return maxTotalFlips;
};