var oddCells = function(m, n, indices) {
    const rows = new Array(m).fill(0);
    const cols = new Array(n).fill(0);

    for (const [r, c] of indices) {
        rows[r] ^= 1;
        cols[c] ^= 1;
    }

    let rowOdds = rows.filter(x => x === 1).length;
    let colOdds = cols.filter(x => x === 1).length;

    return rowOdds * n + colOdds * m - 2 * rowOdds * colOdds;
};