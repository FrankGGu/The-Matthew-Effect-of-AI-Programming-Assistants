function numberOfPoints(cars) {
    const points = new Set();

    for (const [start, end] of cars) {
        for (let i = start; i <= end; i++) {
            points.add(i);
        }
    }

    return points.size;
}