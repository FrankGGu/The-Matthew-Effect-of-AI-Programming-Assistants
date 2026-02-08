class Solution {
    public char[][] rotateTheBox(char[][] box) {
        int m = box.length; // original number of rows
        int n = box[0].length; // original number of columns

        // Step 1: Rotate the box 90 degrees clockwise
        // The new box will have n rows and m columns
        char[][] rotatedBox = new char[n][m];

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                // The element at original box[r][c] moves to rotatedBox[c][m - 1 - r]
                rotatedBox[c][m - 1 - r] = box[r][c];
            }
        }

        // Step 2: Simulate gravity on the rotated box
        // Gravity acts downwards, meaning stones fall to higher row indices in the rotatedBox.

        int rotatedRows = n; // number of rows in the rotated box
        int rotatedCols = m; // number of columns in the rotated box

        // Iterate through each column of the rotatedBox
        for (int j = 0; j < rotatedCols; j++) { 
            // 'targetRow' keeps track of the lowest available position (highest row index)
            // where a stone can fall in the current column.
            int targetRow = rotatedRows - 1; 

            // Iterate from the bottom-most row to the top-most row in the current column
            for (int i = rotatedRows - 1; i >= 0; i--) {
                if (rotatedBox[i][j] == '*') {
                    // If an obstacle is encountered, stones cannot fall past it.
                    // Reset targetRow to the position just above the obstacle.
                    targetRow = i - 1;
                } else if (rotatedBox[i][j] == '#') {
                    // If a stone is found
                    if (i != targetRow) {
                        // If the stone is not already at its lowest possible position, move it.
                        rotatedBox[targetRow][j] = '#';
                        rotatedBox[i][j] = '.'; // The original position becomes empty
                    }
                    // Decrement targetRow, as this position is now occupied by a stone.
                    targetRow--;
                }
                // If rotatedBox[i][j] is '.', it's an empty space that a stone might fall into.
                // No action is needed for empty spaces at their current position.
            }
        }

        return rotatedBox;
    }
}