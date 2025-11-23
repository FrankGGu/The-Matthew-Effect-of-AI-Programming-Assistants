var countPoints = function(points, queries) {
    const result = [];
    for (const query of queries) {
        let count = 0;
        for (const point of points) {
            const x = point[0];
            const y = point[1];
            const centerX = query[0];
            const centerY = query[1];
            const radius = query[2];

            const distanceSquared = (x - centerX) * (x - centerX) + (y - centerY) * (y - centerY);
            if (distanceSquared <= radius * radius) {
                count++;
            }
        }
        result.push(count);
    }
    return result;
};