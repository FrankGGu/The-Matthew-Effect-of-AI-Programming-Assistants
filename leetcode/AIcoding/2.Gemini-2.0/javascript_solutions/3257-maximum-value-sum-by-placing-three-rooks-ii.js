var maxRookAttack = function(board) {
    const m = board.length;
    const n = board[0].length;
    let maxVal = -Infinity;

    for (let r1 = 0; r1 < m; ++r1) {
        for (let c1 = 0; c1 < n; ++c1) {
            for (let r2 = 0; r2 < m; ++r2) {
                if (r2 === r1) continue;
                for (let c2 = 0; c2 < n; ++c2) {
                    if (c2 === c1) continue;
                    for (let r3 = 0; r3 < m; ++r3) {
                        if (r3 === r1 || r3 === r2) continue;
                        for (let c3 = 0; c3 < n; ++c3) {
                            if (c3 === c1 || c3 === c2) continue;

                            let sum = 0;

                            // Rook 1 attack
                            for (let i = 0; i < n; ++i) {
                                if (i !== c1) sum += board[r1][i];
                            }
                            for (let i = 0; i < m; ++i) {
                                if (i !== r1) sum += board[i][c1];
                            }

                            // Rook 2 attack
                            for (let i = 0; i < n; ++i) {
                                if (i !== c2) sum += board[r2][i];
                            }
                            for (let i = 0; i < m; ++i) {
                                if (i !== r2) sum += board[i][c2];
                            }

                            // Rook 3 attack
                            for (let i = 0; i < n; ++i) {
                                if (i !== c3) sum += board[r3][i];
                            }
                            for (let i = 0; i < m; ++i) {
                                if (i !== r3) sum += board[i][c3];
                            }
                            maxVal = Math.max(maxVal, sum);
                        }
                    }
                }
            }
        }
    }

    return maxVal;
};