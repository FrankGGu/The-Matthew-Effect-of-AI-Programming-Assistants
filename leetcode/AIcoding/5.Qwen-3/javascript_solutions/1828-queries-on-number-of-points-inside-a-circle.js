function countPoints(points, queries) {
    const result = [];
    for (const [x, y] of queries) {
        let count = 0;
        for (const [px, py] of points) {
            if ((px - x) * (px - x) + (py - y) * (py - y) <= 1) {
                count++;
            }
        }
        result.push(count);
    }
    return result;
}