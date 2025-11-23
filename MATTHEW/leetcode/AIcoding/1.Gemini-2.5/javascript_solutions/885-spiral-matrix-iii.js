var spiralMatrixIII = function(R, C, rStart, cStart) {
    const result = [];

    // Add the starting cell, which is always within bounds by problem constraints
    result.push([rStart, cStart]);

    // Directions: Right, Down, Left, Up
    // dr: change in row, dc: change in column
    const dr = [0, 1, 0, -1];
    const dc = [1, 0, -1, 0];

    let currentR = rStart;
    let currentC = cStart;
    let stepLength = 1;
    let directionIndex = 0; // 0: Right, 1: Down, 2: Left, 3: Up

    // Continue until all R*C cells are found
    while (result.length < R * C) {
        // Move `stepLength` steps in the current direction
        for (let i = 0; i < stepLength; i++) {
            currentR += dr[directionIndex];
            currentC += dc[directionIndex];

            // Check if the new cell is within the grid
            if (currentR >= 0 && currentR < R && currentC >= 0 && currentC < C) {
                result.push([currentR, currentC]);
            }

            // Optimization: if all cells found, return early
            if (result.length === R * C) {
                return result;
            }
        }

        // Change direction
        directionIndex = (directionIndex + 1) % 4;

        // The step length increases after every two direction changes.
        // E.g., after Right (dir 0) and Down (dir 1), stepLength increases.
        // After Left (dir 2) and Up (dir 3), stepLength increases.
        // This corresponds to when directionIndex becomes 2 (after Down) or 0 (after Up).
        if (directionIndex === 2 || directionIndex === 0) {
            stepLength++;
        }
    }

    return result;
};