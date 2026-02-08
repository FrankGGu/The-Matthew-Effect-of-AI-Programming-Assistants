var checkStraightLine = function(coordinates) {
    const [x0, y0] = coordinates[0];
    const [x1, y1] = coordinates[1];
    const slope = (y1 - y0) / (x1 - x0);

    for (let i = 2; i < coordinates.length; i++) {
        const [xi, yi] = coordinates[i];
        if (slope !== (yi - y0) / (xi - x0)) {
            return false;
        }
    }
    return true;
};