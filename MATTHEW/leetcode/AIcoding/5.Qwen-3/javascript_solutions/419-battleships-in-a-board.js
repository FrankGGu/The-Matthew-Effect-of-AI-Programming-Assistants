function countBattleships(board) {
    if (board.length === 0 || board[0].length === 0) return 0;

    let count = 0;
    const rows = board.length;
    const cols = board[0].length;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (board[i][j] === 'X' && 
                (i === 0 || board[i-1][j] !== 'X') && 
                (j === 0 || board[i][j-1] !== 'X')) {
                count++;
            }
        }
    }

    return count;
}