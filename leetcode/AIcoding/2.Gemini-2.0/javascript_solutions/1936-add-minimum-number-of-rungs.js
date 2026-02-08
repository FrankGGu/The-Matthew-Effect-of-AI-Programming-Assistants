var addRungs = function(rungs, dist) {
    let count = 0;
    let prev = 0;
    for (let i = 0; i < rungs.length; i++) {
        let diff = rungs[i] - prev;
        if (diff > dist) {
            count += Math.ceil(diff / dist) - 1;
        }
        prev = rungs[i];
    }
    return count;
};