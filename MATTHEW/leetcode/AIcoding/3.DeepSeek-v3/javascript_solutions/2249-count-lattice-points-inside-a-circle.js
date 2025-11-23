var countLatticePoints = function(circles) {
    const points = new Set();
    for (const [x, y, r] of circles) {
        const rSquared = r * r;
        for (let i = x - r; i <= x + r; i++) {
            for (let j = y - r; j <= y + r; j++) {
                const dx = i - x;
                const dy = j - y;
                if (dx * dx + dy * dy <= rSquared) {
                    points.add(`${i},${j}`);
                }
            }
        }
    }
    return points.size;
};