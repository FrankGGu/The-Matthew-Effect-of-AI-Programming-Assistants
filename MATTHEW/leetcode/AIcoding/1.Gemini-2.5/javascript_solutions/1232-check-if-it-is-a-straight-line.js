var checkStraightLine = function(coordinates) {
    if (coordinates.length <= 2) {
        return true;
    }

    const x0 = coordinates[0][0];
    const y0 = coordinates[0][1];
    const x1 = coordinates[1][0];
    const y1 = coordinates[1][1];

    const deltaY = y1 - y0;
    const deltaX = x1 - x0;

    for (let i = 2; i < coordinates.length; i++) {
        const xi = coordinates[i][0];
        const yi = coordinates[i][1];

        // Check if (yi - y0) / (xi - x0) == deltaY / deltaX
        // To avoid division by zero and floating point issues, cross-multiply:
        // (yi - y0) * deltaX == (xi - x0) * deltaY
        if ((yi - y0) * deltaX !== (xi - x0) * deltaY) {
            return false;
        }
    }

    return true;
};