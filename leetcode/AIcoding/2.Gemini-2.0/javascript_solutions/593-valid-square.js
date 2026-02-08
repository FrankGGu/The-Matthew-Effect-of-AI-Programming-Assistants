var validSquare = function(p1, p2, p3, p4) {
    const dist = (p1, p2) => (p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2;

    const distances = [
        dist(p1, p2),
        dist(p1, p3),
        dist(p1, p4),
        dist(p2, p3),
        dist(p2, p4),
        dist(p3, p4)
    ];

    distances.sort((a, b) => a - b);

    if (distances[0] === 0) return false;

    return distances[0] === distances[1] &&
           distances[1] === distances[2] &&
           distances[2] === distances[3] &&
           distances[4] === distances[5] &&
           distances[5] === 2 * distances[0];
};