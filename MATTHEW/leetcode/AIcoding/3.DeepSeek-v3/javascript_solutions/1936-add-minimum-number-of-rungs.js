var addRungs = function(rungs, dist) {
    let count = 0;
    let prev = 0;
    for (let i = 0; i < rungs.length; i++) {
        const diff = rungs[i] - prev;
        if (diff > dist) {
            count += Math.floor((diff - 1) / dist);
        }
        prev = rungs[i];
    }
    return count;
};