var DetectSquares = function() {
    this.points = new Map();
};

DetectSquares.prototype.add = function(point) {
    const x = point[0];
    const y = point[1];
    const key = `${x},${y}`;
    this.points.set(key, (this.points.get(key) || 0) + 1);
};

DetectSquares.prototype.count = function(point) {
    let count = 0;
    const x = point[0];
    const y = point[1];

    for (const key of this.points.keys()) {
        const [x1, y1] = key.split(',').map(Number);
        if (Math.abs(x - x1) === 0 || Math.abs(x - x1) !== Math.abs(y - y1)) {
            continue;
        }

        const side = Math.abs(x - x1);
        const p1Key = `${x},${y1}`;
        const p2Key = `${x1},${y}`;

        if (this.points.has(p1Key) && this.points.has(p2Key)) {
            count += this.points.get(key) * this.points.get(p1Key) * this.points.get(p2Key);
        }
    }

    return count;
};