var minCost = function(startPos, homePos, rowCosts, colCosts) {
    let totalCost = 0;

    let startRow = startPos[0];
    let startCol = startPos[1];
    let homeRow = homePos[0];
    let homeCol = homePos[1];

    // Calculate cost for moving vertically (rows)
    if (startRow < homeRow) {
        for (let i = startRow + 1; i <= homeRow; i++) {
            totalCost += rowCosts[i];
        }
    } else if (startRow > homeRow) {
        for (let i = startRow - 1; i >= homeRow; i--) {
            totalCost += rowCosts[i];
        }
    }

    // Calculate cost for moving horizontally (columns)
    if (startCol < homeCol) {
        for (let j = startCol + 1; j <= homeCol; j++) {
            totalCost += colCosts[j];
        }
    } else if (startCol > homeCol) {
        for (let j = startCol - 1; j >= homeCol; j--) {
            totalCost += colCosts[j];
        }
    }

    return totalCost;
};