var minCost = function(startPos, homePos, rowCosts, colCosts) {
    let cost = 0;
    let startRow = startPos[0];
    let startCol = startPos[1];
    let homeRow = homePos[0];
    let homeCol = homePos[1];

    if (startRow < homeRow) {
        for (let i = startRow + 1; i <= homeRow; i++) {
            cost += rowCosts[i];
        }
    } else if (startRow > homeRow) {
        for (let i = startRow - 1; i >= homeRow; i--) {
            cost += rowCosts[i];
        }
    }

    if (startCol < homeCol) {
        for (let i = startCol + 1; i <= homeCol; i++) {
            cost += colCosts[i];
        }
    } else if (startCol > homeCol) {
        for (let i = startCol - 1; i >= homeCol; i--) {
            cost += colCosts[i];
        }
    }

    return cost;
};