var findSolution = function(customfunction, z) {
    let result = [];
    for (let x = 1; x <= 1000; x++) {
        for (let y = 1; y <= 1000; y++) {
            if (customfunction.f(x, y) === z) {
                result.push([x, y]);
            }
        }
    }
    return result;
};