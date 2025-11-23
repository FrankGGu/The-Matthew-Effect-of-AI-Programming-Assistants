var minCost = function(startPos, targetPos, rowCosts, colCosts) {
    let rowStart = startPos[0];
    let colStart = startPos[1];
    let rowTarget = targetPos[0];
    let colTarget = targetPos[1];

    let rowCost = 0;
    if (rowStart < rowTarget) {
        for (let i = rowStart + 1; i <= rowTarget; i++) {
            rowCost += rowCosts[i];
        }
    } else {
        for (let i = rowStart - 1; i >= rowTarget; i--) {
            rowCost += rowCosts[i];
        }
    }

    let colCost = 0;
    if (colStart < colTarget) {
        for (let i = colStart + 1; i <= colTarget; i++) {
            colCost += colCosts[i];
        }
    } else {
        for (let i = colStart - 1; i >= colTarget; i--) {
            colCost += colCosts[i];
        }
    }

    return rowCost + colCost;
};