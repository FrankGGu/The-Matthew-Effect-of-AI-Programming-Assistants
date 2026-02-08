var countBattleships = function(board) {
    let count = 0;
    const m = board.length;
    if (m === 0) {
        return 0;
    }
    const n = board[0].length;
    if (n === 0) {
        return 0;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (board[i][j] === 'X') {
                // Check if this 'X' is the top-most and left-most part of a battleship.
                // If the cell directly above is 'X', it's part of a battleship whose top-most 'X' was already or will be counted.
                // If the cell directly to the left is 'X', it's part of a battleship whose left-most 'X' was already or will be counted.
                // We only count if neither of these conditions is true, meaning it's a new battleship's top-left corner.
                const isTopMost = (i === 0 || board[i - 1][j] === '.');
                const isLeftMost = (j === 0 || board[i][j - 1] === '.');

                if (isTopMost && isLeftMost) {
                    count++;
                }
            }
        }
    }

    return count;
};