function mysteriousFunction(x, y) {
    return (x & ~y) | (~x & y);
}

function findMysteryNumber(a, b) {
    return mysteriousFunction(a, b);
}