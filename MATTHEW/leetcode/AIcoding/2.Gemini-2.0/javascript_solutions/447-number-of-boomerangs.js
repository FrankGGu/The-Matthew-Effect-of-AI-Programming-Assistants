var numberOfBoomerangs = function(points) {
    let count = 0;
    for (let i = 0; i < points.length; i++) {
        const map = new Map();
        for (let j = 0; j < points.length; j++) {
            if (i === j) continue;
            const distance = (points[i][0] - points[j][0]) ** 2 + (points[i][1] - points[j][1]) ** 2;
            map.set(distance, (map.get(distance) || 0) + 1);
        }
        for (const value of map.values()) {
            count += value * (value - 1);
        }
    }
    return count;
};