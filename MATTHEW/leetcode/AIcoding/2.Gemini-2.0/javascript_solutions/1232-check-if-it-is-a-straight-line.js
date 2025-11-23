var checkStraightLine = function(coordinates) {
    if (coordinates.length <= 2) return true;

    let x0 = coordinates[0][0];
    let y0 = coordinates[0][1];
    let x1 = coordinates[1][0];
    let y1 = coordinates[1][1];

    let dx = x1 - x0;
    let dy = y1 - y0;

    for (let i = 2; i < coordinates.length; i++) {
        let x = coordinates[i][0];
        let y = coordinates[i][1];

        if (dx * (y - y0) !== dy * (x - x0)) {
            return false;
        }
    }

    return true;
};