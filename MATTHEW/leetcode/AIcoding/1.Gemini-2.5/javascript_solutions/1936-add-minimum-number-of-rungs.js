var addRungs = function(rungs, dist) {
    let addedRungs = 0;
    let currentPos = 0;

    for (let i = 0; i < rungs.length; i++) {
        const rung = rungs[i];
        const gap = rung - currentPos;

        if (gap > dist) {
            addedRungs += Math.floor((gap - 1) / dist);
        }
        currentPos = rung;
    }

    return addedRungs;
};