var checkMove = function(board, rMove, cMove, color) {
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]];
    const oppositeColor = color === 'B' ? 'W' : 'B';

    for (const [dr, dc] of directions) {
        let r = rMove + dr;
        let c = cMove + dc;
        let foundOpposite = false;

        while (r >= 0 && r < 8 && c >= 0 && c < 8) {
            if (board[r][c] === oppositeColor) {
                foundOpposite = true;
            } else if (board[r][c] === color && foundOpposite) {
                return true;
            } else {
                break;
            }
            r += dr;
            c += dc;
        }
    }

    return false;
};