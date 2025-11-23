var numMovesStones = function(a, b, c) {
    let [x, y, z] = [a, b, c].sort((x, y) => x - y);
    let max = z - x - 2;
    let min;
    if (z - x === 2) {
        min = 0;
    } else if (y - x <= 2 || z - y <= 2) {
        min = 1;
    } else {
        min = 2;
    }
    return [min, max];
};