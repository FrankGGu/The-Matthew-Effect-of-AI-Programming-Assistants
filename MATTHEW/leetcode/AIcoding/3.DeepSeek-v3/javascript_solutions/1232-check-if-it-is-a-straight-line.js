var checkStraightLine = function(coordinates) {
    if (coordinate.length <= 2) return true;
    const [x0, y0] = coordinate[0];
    const [x1, y1] = coordinate[1];
    const dx = x1 - x0;
    const dy = y1 - y0;

    for (let i = 2; i < coordinate.length; i++) {
        const [xi, yi] = coordinate[i];
        if (dy * (xi - x0) !== dx * (yi - y0)) {
            return false;
        }
    }
    return true;
};