var findSolution = function(customfunction, z) {
    const solutions = [];

    for (let x = 1; x <= 1000; x++) {
        if (customfunction.f(x, 1) > z) {
            break;
        }

        for (let y = 1; y <= 1000; y++) {
            const val = customfunction.f(x, y);

            if (val === z) {
                solutions.push([x, y]);
                break;
            } else if (val > z) {
                break;
            }
        }
    }

    return solutions;
};