var decodeCiphertext = function(encodedText, rows) {
    const n = encodedText.length;
    if (n === 0) {
        return "";
    }

    const cols = n / rows;

    // Create a grid to reconstruct the original message layout.
    // The grid will have 'rows' rows and 'cols' columns.
    const grid = Array(rows).fill(0).map(() => Array(cols).fill(''));

    let encodedTextIndex = 0;

    // Fill the grid by reversing the diagonal reading process described.
    // The problem states: "the first diagonal is grid[0][0], grid[1][1], grid[2][2], ...
    // then the second diagonal is grid[0][1], grid[1][2], [2][3], ..., and so on."
    // This implies iterating through diagonals where the difference (c - r) is constant.
    // 'diff' represents this constant difference (c - r).
    // It starts from 0 (for grid[0][0], grid[1][1], ...) and goes up to cols - 1 (for grid[0][cols-1]).
    for (let diff = 0; diff < cols; diff++) {
        // For each diagonal, iterate through its elements.
        // The row 'r' starts from 0 and increments.
        // The column 'c' is determined by 'r' and 'diff': c = r + diff.
        for (let r = 0; r < rows; r++) {
            const c = r + diff;
            // Check if the calculated column 'c' is within the grid bounds.
            if (c < cols) {
                // Place the character from encodedText into the grid cell (r, c).
                grid[r][c] = encodedText[encodedTextIndex];
                encodedTextIndex++;
            } else {
                // If 'c' is out of bounds, this diagonal has ended for the current row count.
                // Break from the inner loop and move to the next diagonal (increment 'diff').
                break;
            }
        }
    }

    // Reconstruct the original message by reading the grid row by row.
    let decodedMessageChars = [];
    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            decodedMessageChars.push(grid[r][c]);
        }
    }

    // Convert the array of characters to a string and remove any trailing spaces.
    return decodedMessageChars.join('').trimEnd();
};