function countLatticePoints(circles) {
    const points = new Set();

    for (const [x, y, r] of circles) {
        for (let i = -r; i <= r; i++) {
            const h = Math.sqrt(r * r - i * i);
            for (let j = -Math.floor(h); j <= Math.floor(h); j++) {
                points.add(`${x + i},${y + j}`);
            }
        }
    }

    return points.size;
}