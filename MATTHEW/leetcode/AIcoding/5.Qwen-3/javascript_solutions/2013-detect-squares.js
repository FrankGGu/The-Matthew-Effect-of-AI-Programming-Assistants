var DetectSquares = function() {
    this.points = new Map();
};

DetectSquares.prototype.add = function(point) {
    const key = point[0] + ',' + point[1];
    this.points.set(key, (this.points.get(key) || 0) + 1);
};

DetectSquares.prototype.count = function(point) {
    const [x, y] = point;
    let count = 0;
    for (const [px, py] of this.points.keys()) {
        const pxInt = parseInt(px);
        const pyInt = parseInt(py);
        if (pxInt === x || pyInt === y) continue;
        if (this.points.has(pxInt + ',' + y) && this.points.has(x + ',' + pyInt)) {
            count += this.points.get(px + ',' + py) * this.points.get(px + ',' + y) * this.points.get(x + ',' + py);
        }
    }
    return count;
};