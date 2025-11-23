var checkMove = function(board, rMove, cMove, color) {
    if (board[rMove][cMove] !== '.') return false;
    const directions = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]];
    let valid = false;

    for (const [dr, dc] of directions) {
        let row = rMove + dr, col = cMove + dc, count = 0;
        while (row >= 0 && row < 8 && col >= 0 && col < 8) {
            if (board[row][col] === '.') break;
            if (board[row][col] === color) {
                if (count > 0) {
                    valid = true;
                }
                break;
            }
            count++;
            row += dr;
            col += dc;
        }
    }
    return valid;
};