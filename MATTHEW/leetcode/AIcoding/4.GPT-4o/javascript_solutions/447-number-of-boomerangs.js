var numberOfBoomerangs = function(points) {
    let result = 0;

    for (let i = 0; i < points.length; i++) {
        const count = new Map();
        for (let j = 0; j < points.length; j++) {
            if (i !== j) {
                const dx = points[i][0] - points[j][0];
                const dy = points[i][1] - points[j][1];
                const distance = dx * dx + dy * dy;
                count.set(distance, (count.get(distance) || 0) + 1);
            }
        }

        for (let value of count.values()) {
            result += value * (value - 1);
        }
    }

    return result;
};