var sortedSquares = function(A) {
    return A.map(x => x * x).sort((a, b) => a - b);
};