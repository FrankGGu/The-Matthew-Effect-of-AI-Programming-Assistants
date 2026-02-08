var musicalPosition = function(num) {
    let n = num;
    let layer = 0;
    while (n > 0) {
        layer++;
        if (n <= 4 * (layer - 1)) {
            break;
        }
        n -= 4 * (layer - 1);
    }

    let sideLength = 2 * layer - 1;
    let offset = n;

    if (offset <= sideLength) {
        return offset;
    } else if (offset <= 2 * sideLength - 1) {
        return sideLength + (sideLength - (offset - sideLength));
    } else if (offset <= 3 * sideLength - 2) {
        return sideLength + (sideLength - 1) + (sideLength - (offset - (2 * sideLength - 1)));
    } else {
        return sideLength * 3 - 2 + (sideLength - (offset - (3 * sideLength - 2)));
    }
};