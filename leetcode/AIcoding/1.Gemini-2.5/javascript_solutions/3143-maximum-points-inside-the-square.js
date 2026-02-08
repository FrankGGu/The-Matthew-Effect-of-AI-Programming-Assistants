var maxPointsInsideTheSquare = function(points) {
    const distinctSValues = new Set();

    for (const point of points) {
        const x = point[0];
        const y = point[1];
        const s = Math.max(Math.abs(x), Math.abs(y));
        distinctSValues.add(s);
    }

    return distinctSValues.size;
};