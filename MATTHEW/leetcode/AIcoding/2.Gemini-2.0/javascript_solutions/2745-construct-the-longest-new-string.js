var longestString = function(x, y, z) {
    if (x === y) {
        return (x + y + z) * 2;
    } else if (x > y) {
        return (y + y + 1 + z) * 2;
    } else {
        return (x + x + 1 + z) * 2;
    }
};