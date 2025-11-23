var countPoints = function(points, queries) {
    const results = [];

    for (let i = 0; i < queries.length; i++) {
        const [cx, cy, r] = queries[i];
        let count = 0;
        const rSquared = r * r;

        for (let j = 0; j < points.length; j++) {
            const [px, py] = points[j];
            const dx = px - cx;
            const dy = py - cy;
            const distanceSquared = dx * dx + dy * dy;

            if (distanceSquared <= rSquared) {
                count++;
            }
        }
        results.push(count);
    }

    return results;
};