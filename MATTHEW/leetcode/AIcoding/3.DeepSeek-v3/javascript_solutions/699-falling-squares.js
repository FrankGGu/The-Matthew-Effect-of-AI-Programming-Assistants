var fallingSquares = function(positions) {
    let intervals = [];
    let res = [];
    let maxHeight = 0;

    for (let [left, sideLength] of positions) {
        let right = left + sideLength;
        let baseHeight = 0;

        for (let [l, r, h] of intervals) {
            if (r > left && l < right) {
                baseHeight = Math.max(baseHeight, h);
            }
        }

        let newHeight = baseHeight + sideLength;
        intervals.push([left, right, newHeight]);
        maxHeight = Math.max(maxHeight, newHeight);
        res.push(maxHeight);
    }

    return res;
};