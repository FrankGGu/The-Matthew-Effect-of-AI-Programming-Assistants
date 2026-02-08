var isValidSudoku = function(board) {
    const rows = Array(9).fill(0).map(() => new Set());
    const cols = Array(9).fill(0).map(() => new Set());
    const boxes = Array(9).fill(0).map(() => new Set());

    for (let i = 0; i < 9; i++) {
        for (let j = 0; j < 9; j++) {
            const char = board[i][j];
            if (char === '.') {
                continue;
            }

            const num = parseInt(char);
            const boxIndex = Math.floor(i / 3) * 3 + Math.floor(j / 3);

            if (rows[i].has(num) || cols[j].has(num) || boxes[boxIndex].has(num)) {
                return false;
            }

            rows[i].add(num);
            cols[j].add(num);
            boxes[boxIndex].add(num);
        }
    }

    return true;
};