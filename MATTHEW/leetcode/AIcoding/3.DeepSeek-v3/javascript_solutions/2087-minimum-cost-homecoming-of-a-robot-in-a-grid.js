var minCost = function(startPos, homePos, rowCosts, colCosts) {
    let totalCost = 0;
    let [startRow, startCol] = startPos;
    let [homeRow, homeCol] = homePos;

    if (startRow < homeRow) {
        for (let i = startRow + 1; i <= homeRow; i++) {
            totalCost += rowCosts[i];
        }
    } else if (startRow > homeRow) {
        for (let i = startRow - 1; i >= homeRow; i--) {
            totalCost += rowCosts[i];
        }
    }

    if (startCol < homeCol) {
        for (let i = startCol + 1; i <= homeCol; i++) {
            totalCost += colCosts[i];
        }
    } else if (startCol > homeCol) {
        for (let i = startCol - 1; i >= homeCol; i--) {
            totalCost += colCosts[i];
        }
    }

    return totalCost;
};