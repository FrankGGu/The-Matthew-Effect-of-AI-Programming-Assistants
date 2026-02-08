var assignPieces = function(pieces, positions) {
    const n = pieces.length;
    const m = positions.length;
    const used = new Array(m).fill(false);
    let minTotal = Infinity;

    function backtrack(index, total) {
        if (index === n) {
            if (total < minTotal) {
                minTotal = total;
            }
            return;
        }

        for (let i = 0; i < m; i++) {
            if (!used[i]) {
                used[i] = true;
                const dist = Math.abs(pieces[index][0] - positions[i][0]) + 
                              Math.abs(pieces[index][1] - positions[i][1]);
                backtrack(index + 1, total + dist);
                used[i] = false;
            }
        }
    }

    backtrack(0, 0);
    return minTotal;
};