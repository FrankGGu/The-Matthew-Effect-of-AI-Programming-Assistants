var DetectSquares = function() {
    this.pointsCount = Array(1001).fill(0).map(() => Array(1001).fill(0));
    this.allPoints = [];
};

DetectSquares.prototype.add = function(point) {
    const x = point[0];
    const y = point[1];
    if (this.pointsCount[x][y] === 0) {
        this.allPoints.push(point);
    }
    this.pointsCount[x][y]++;
};

DetectSquares.prototype.count = function(point) {
    const x1 = point[0];
    const y1 = point[1];
    let totalSquares = 0;

    for (const p2 of this.allPoints) {
        const x2 = p2[0];
        const y2 = p2[1];

        if (x1 === x2 || y1 === y2) {
            continue;
        }

        if (Math.abs(x1 - x2) === Math.abs(y1 - y2)) {
            const count3 = this.pointsCount[x1][y2];
            const count4 = this.pointsCount[x2][y1];

            if (count3 > 0 && count4 > 0) {
                totalSquares += this.pointsCount[x2][y2] * count3 * count4;
            }
        }
    }

    return totalSquares;
};