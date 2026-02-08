var findIndicesOfStableMountains = function(mountain) {
    const n = mountain.length;
    const result = [];

    for (let i = 0; i < n - 1; i++) {
        if (Math.abs(mountain[i + 1] - mountain[i]) <= 1) {
            let j = i + 1;
            while (j < n - 1 && Math.abs(mountain[j + 1] - mountain[j]) <= 1) {
                j++;
            }
            result.push([i, j]);
            i = j;
        }
    }

    return result;
};