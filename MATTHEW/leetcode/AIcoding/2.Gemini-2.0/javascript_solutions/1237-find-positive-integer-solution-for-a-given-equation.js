var findSolution = function(customfunction, z) {
    const result = [];
    for (let x = 1; x <= 1000; x++) {
        let low = 1;
        let high = 1000;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            const val = customfunction.f(x, mid);
            if (val === z) {
                result.push([x, mid]);
                break;
            } else if (val < z) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
    }
    return result;
};