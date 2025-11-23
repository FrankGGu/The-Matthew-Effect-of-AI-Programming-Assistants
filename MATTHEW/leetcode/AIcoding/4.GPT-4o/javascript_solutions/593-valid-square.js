var validSquare = function(p1, p2, p3, p4) {
    const distance = (a, b) => (b[0] - a[0]) ** 2 + (b[1] - a[1]) ** 2;
    const dists = [
        distance(p1, p2), distance(p1, p3), distance(p1, p4),
        distance(p2, p3), distance(p2, p4), distance(p3, p4)
    ];
    const count = {};
    for (const d of dists) {
        if (d > 0) {
            count[d] = (count[d] || 0) + 1;
        }
    }
    return Object.keys(count).length === 2 && Object.values(count).sort().toString() === [4, 2].toString();
};