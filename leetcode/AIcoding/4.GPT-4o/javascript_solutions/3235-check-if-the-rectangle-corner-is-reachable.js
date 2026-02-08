function isReachable(x, y) {
    return (x + y) % 2 === 0 && Math.abs(x) % 2 === Math.abs(y) % 2;
}