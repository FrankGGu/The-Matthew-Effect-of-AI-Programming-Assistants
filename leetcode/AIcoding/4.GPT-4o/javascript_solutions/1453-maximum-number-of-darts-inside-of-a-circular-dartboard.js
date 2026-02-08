var numDartsInCircumscribedCircle = function(r, x, y, darts) {
    let count = 0;
    for (const [dx, dy] of darts) {
        if (Math.pow(dx - x, 2) + Math.pow(dy - y, 2) <= Math.pow(r, 2)) {
            count++;
        }
    }
    return count;
};