var brokenCalc = function(X, Y) {
    let steps = 0;
    while (Y > X) {
        if (Y % 2 === 0) {
            Y /= 2;
        } else {
            Y += 1;
        }
        steps++;
    }
    return steps + (X - Y);
};