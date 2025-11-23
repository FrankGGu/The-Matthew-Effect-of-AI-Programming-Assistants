function tictactoe(moves) {
    const n = 3;
    const rows = new Array(n).fill(0);
    const cols = new Array(n).fill(0);
    let diag = 0;
    let antiDiag = 0;

    for (let i = 0; i < moves.length; i++) {
        const [x, y] = moves[i];
        const player = i % 2 === 0 ? 1 : -1;

        rows[x] += player;
        cols[y] += player;

        if (x === y) diag += player;
        if (x + y === n - 1) antiDiag += player;
    }

    for (let i = 0; i < n; i++) {
        if (rows[i] === n || cols[i] === n) return "A";
        if (rows[i] === -n || cols[i] === -n) return "B";
    }

    if (diag === n || antiDiag === n) return "A";
    if (diag === -n || antiDiag === -n) return "B";

    return moves.length === n * n ? "Draw" : "Pending";
}