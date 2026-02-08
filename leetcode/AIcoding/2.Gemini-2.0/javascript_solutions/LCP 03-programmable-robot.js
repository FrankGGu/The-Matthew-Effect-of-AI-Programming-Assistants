var isProgrammableRobot = function(numRows, numCols, startPos, s) {
    let row = startPos[0];
    let col = startPos[1];

    for (let i = 0; i < s.length; i++) {
        const move = s[i];
        if (move === 'U') {
            row--;
        } else if (move === 'D') {
            row++;
        } else if (move === 'L') {
            col--;
        } else {
            col++;
        }

        if (row < 0 || row >= numRows || col < 0 || col >= numCols) {
            return false;
        }
    }

    return true;
};