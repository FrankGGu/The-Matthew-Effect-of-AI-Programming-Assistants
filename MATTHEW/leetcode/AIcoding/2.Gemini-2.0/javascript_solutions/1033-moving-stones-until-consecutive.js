var numMovesStones = function(a) {
    a.sort((x, y) => x - y);
    let x = a[0], y = a[1], z = a[2];
    let min = 0, max = z - x - 2;
    if (z - y == 1 && y - x == 1) {
        min = 0;
    } else if (z - y <= 2 || y - x <= 2) {
        min = 1;
    } else {
        min = 2;
    }
    return [min, max];
};