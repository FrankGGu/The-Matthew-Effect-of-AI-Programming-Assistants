function isReachable(x, y) {
    while (x > 0 && y > 0) {
        if (x > y) {
            x %= y;
        } else {
            y %= x;
        }
    }
    return (x === 0 && y > 0) || (y === 0 && x > 0);
}