var checkMove = function(board, rMove, cMove, color) {
    const n = board.length;
    const m = board[0].length;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]];

    for (const [dr, dc] of directions) {
        let count = 0;
        let r = rMove + dr;
        let c = cMove + dc;

        while (r >= 0 && r < n && c >= 0 && c < m) {
            if (board[r][c] === '.') {
                break;
            } else if (board[r][c] === color) {
                if (count >= 1) {
                    return true;
                }
                break;
            } else {
                count++;
                r += dr;
                c += dc;
            }
        }
    }

    return false;
};