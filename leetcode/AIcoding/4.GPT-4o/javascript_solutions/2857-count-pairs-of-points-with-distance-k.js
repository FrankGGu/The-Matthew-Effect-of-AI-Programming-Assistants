function countPairs(points, k) {
    let count = 0;
    const distance = (p1, p2) => Math.abs(p1[0] - p2[0]) + Math.abs(p1[1] - p2[1]);

    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            if (distance(points[i], points[j]) === k) {
                count++;
            }
        }
    }

    return count;
}