var addRungs = function(rungs, dist) {
    let count = 0;
    let current = 0;

    for (let i = 0; i < rungs.length; i++) {
        while (rungs[i] - current > dist) {
            current += dist;
            count++;
        }
        current = rungs[i];
    }

    return count;
};