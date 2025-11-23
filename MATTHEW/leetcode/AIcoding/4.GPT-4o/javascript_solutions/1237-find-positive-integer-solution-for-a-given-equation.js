var findSolution = function(a, b, c) {
    const result = [];
    for (let x = 1; x <= c; x++) {
        const y = (c - a * x) / b;
        if (y > 0 && Number.isInteger(y)) {
            result.push([x, y]);
        }
    }
    return result;
};