var countPoints = function(points, queries) {
    return queries.map(([x, y, r]) => {
        let count = 0;
        for (const [px, py] of points) {
            const dx = px - x;
            const dy = py - y;
            if (dx * dx + dy * dy <= r * r) {
                count++;
            }
        }
        return count;
    });
};