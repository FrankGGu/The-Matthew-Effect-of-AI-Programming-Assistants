var numberOfBoomerangs = function(points) {
    let count = 0;
    for (let i = 0; i < points.length; i++) {
        const map = new Map();
        for (let j = 0; j < points.length; j++) {
            if (i === j) continue;
            const dx = points[i][0] - points[j][0];
            const dy = points[i][1] - points[j][1];
            const distance = dx * dx + dy * dy;
            map.set(distance, (map.get(distance) || 0) + 1);
        }
        for (const [key, value] of map) {
            count += value * (value - 1);
        }
    }
    return count;
};