var queensAttacktheKing = function(queens, king) {
    const board = new Array(8).fill(0).map(() => new Array(8).fill(false));
    for (const [r, c] of queens) {
        board[r][c] = true;
    }

    const result = [];
    const kr = king[0];
    const kc = king[1];

    const dr = [-1, -1, -1, 0, 0, 1, 1, 1];
    const dc = [-1, 0, 1, -1, 1, -1, 0, 1];

    for (let i = 0; i < 8; i++) {
        let r = kr + dr[i];
        let c = kc + dc[i];

        while (r >= 0 && r < 8 && c >= 0 && c < 8) {
            if (board[r][c]) {
                result.push([r, c]);
                break;
            }
            r += dr[i];
            c += dc[i];
        }
    }

    return result;
};