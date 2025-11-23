var tictactoe = function(moves) {
    const board = Array(3).fill(0).map(() => Array(3).fill(0));
    const rows = Array(3).fill(0);
    const cols = Array(3).fill(0);
    let diag1 = 0; // Main diagonal (0,0), (1,1), (2,2)
    let diag2 = 0; // Anti-diagonal (0,2), (1,1), (2,0)

    for (let i = 0; i < moves.length; i++) {
        const [r, c] = moves[i];
        const player = (i % 2 === 0) ? 1 : -1; // 1 for A, -1 for B

        board[r][c] = player;
        rows[r] += player;
        cols[c] += player;

        if (r === c) {
            diag1 += player;
        }
        if (r + c === 2) {
            diag2 += player;
        }

        if (Math.abs(rows[r]) === 3 ||
            Math.abs(cols[c]) === 3 ||
            Math.abs(diag1) === 3 ||
            Math.abs(diag2) === 3) {
            return (player === 1) ? "A" : "B";
        }
    }

    if (moves.length === 9) {
        return "Draw";
    } else {
        return "Pending";
    }
};