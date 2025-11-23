var longestString = function(x, y, z) {
    let minXY = Math.min(x, y);
    if (x === y) {
        return (x + y + z) * 2;
    } else {
        return (minXY * 2 + 1 + z) * 2;
    }
};