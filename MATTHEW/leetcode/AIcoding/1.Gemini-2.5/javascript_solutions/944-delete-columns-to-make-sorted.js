var minDeletionSize = function(strs) {
    if (strs.length === 0) {
        return 0;
    }

    let deletedColumnCount = 0;
    const numRows = strs.length;
    const numCols = strs[0].length;

    for (let j = 0; j < numCols; j++) { // Iterate through columns
        for (let i = 0; i < numRows - 1; i++) { // Iterate through rows for the current column
            if (strs[i][j] > strs[i + 1][j]) {
                deletedColumnCount++;
                break; // This column is not sorted, move to the next column
            }
        }
    }

    return deletedColumnCount;
};