var isValidSudoku = function(board) {
    for (let i = 0; i < 9; i++) {
        let rowSet = new Set();
        let colSet = new Set();
        let boxSet = new Set();

        for (let j = 0; j < 9; j++) {
            let rowVal = board[i][j];
            let colVal = board[j][i];
            let boxVal = board[3 * Math.floor(i / 3) + Math.floor(j / 3)][3 * (i % 3) + (j % 3)];

            if (rowVal !== '.') {
                if (rowSet.has(rowVal)) return false;
                rowSet.add(rowVal);
            }

            if (colVal !== '.') {
                if (colSet.has(colVal)) return false;
                colSet.add(colVal);
            }

            if (boxVal !== '.') {
                if (boxSet.has(boxVal)) return false;
                boxSet.add(boxVal);
            }
        }
    }
    return true;
};