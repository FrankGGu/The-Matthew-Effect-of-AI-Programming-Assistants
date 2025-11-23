var rotateTheBox = function(box) {
    const m = box.length;
    const n = box[0].length;

    // Step 1: Rotate the box 90 degrees clockwise
    // The new box will have n rows and m columns.
    // A cell (r, c) in the original box moves to (c, m - 1 - r) in the rotated box.
    const rotatedBox = Array(n).fill(0).map(() => Array(m).fill(''));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            rotatedBox[c][m - 1 - r] = box[r][c];
        }
    }

    // Step 2: Apply gravity to the rotated box
    // Gravity acts downwards, meaning stones fall to larger row indices.
    // Iterate through each column of the rotated box.
    const numRowsRotated = n; // Number of rows in the rotated box
    const numColsRotated = m; // Number of columns in the rotated box

    for (let j = 0; j < numColsRotated; j++) { // Iterate through each column
        let fallPosition = numRowsRotated - 1; // The lowest available row for a stone in this column

        // Iterate from the bottom of the column upwards
        for (let i = numRowsRotated - 1; i >= 0; i--) {
            if (rotatedBox[i][j] === '*') {
                // An obstacle stops stones above it.
                // The next available fall position is just above this obstacle.
                fallPosition = i - 1;
            } else if (rotatedBox[i][j] === '#') {
                // A stone needs to fall.
                if (i !== fallPosition) {
                    // If the stone is not already at its lowest possible position, move it.
                    rotatedBox[fallPosition][j] = '#';
                    rotatedBox[i][j] = '.'; // The original spot becomes empty
                }
                // Decrement fallPosition for the next stone that might fall in this column
                fallPosition--;
            }
            // If it's '.', do nothing, it's an empty space, potentially a landing spot.
        }
    }

    return rotatedBox;
};