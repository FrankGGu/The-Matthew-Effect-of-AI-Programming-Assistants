var findSolution = function(customfunction, z) {
    var result = [];
    for (var x = 1; x <= 100; x++) {
        for (var y = 1; y <= 100; y++) {
            if (customfunction.f(x, y) === z) {
                result.push([x, y]);
            }
        }
    }
    return result;
};