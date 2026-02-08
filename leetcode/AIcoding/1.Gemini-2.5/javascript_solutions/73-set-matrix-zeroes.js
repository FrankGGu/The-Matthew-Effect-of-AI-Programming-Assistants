var setZeroes = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;

    let col0Flag = 1; // Use col0Flag to track if the first column needs to be zeroed

    // First pass: Use first row and first column as markers
    // Also, determine if the actual first column needs to be zeroed
    for (let i = 0; i < m; i++) {
        // Check if any element in the first column is 0
        // This must be done before matrix[i][0] might be overwritten as a row marker
        if (matrix[i][0] === 0) {
            col0Flag = 0; 
        }

        // Iterate through columns starting from the second column (j=1)
        // If matrix[i][j] is 0, mark its corresponding first row and first column elements
        for (let j = 1; j < n; j++) {
            if (matrix[i][j] === 0) {
                matrix[i][0] = 0; // Mark corresponding row
                matrix[0][j] = 0; // Mark corresponding column
            }
        }
    }

    // Second pass: Set zeros based on markers, starting from bottom-right
    // This order is crucial to avoid using an already zeroed marker (from a later cell)
    // to incorrectly zero out cells that shouldn't be zeroed by an *original* zero.
    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 1; j--) { // Start j from 1
            // If the row marker (matrix[i][0]) or column marker (matrix[0][j]) is 0, set matrix[i][j] to 0
            if (matrix[i][0] === 0 || matrix[0][j] === 0) {
                matrix[i][j] = 0;
            }
        }
        // After processing row i for columns j=1 to n-1,
        // handle matrix[i][0] based on the col0Flag
        if (col0Flag === 0) {
            matrix[i][0] = 0;
        }
    }
};