var countLatticePoints = function(circles) {
    const points = new Set();

    for (const [x, y, r] of circles) {
        for (let i = x - r; i <= x + r; i++) {
            for (let j = y - r; j <= y + r; j++) {
                if ((i - x) * (i - x) + (j - y) * (j - y) <= r * r) {
                    points.add(`${i},${j}`);
                }
            }
        }
    }

    return points.size;
};