function outerTrees(trees) {
    if (trees.length === 0) return [];
    if (trees.length === 1) return trees;

    trees.sort((a, b) => a[0] !== b[0] ? a[0] - b[0] : a[1] - b[1]);

    const cross = (p, q, r) => {
        return (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1]);
    };

    const convexHull = (points) => {
        let lower = [];
        for (let p of points) {
            while (lower.length >= 2 && cross(lower[lower.length - 2], lower[lower.length - 1], p) < 0) {
                lower.pop();
            }
            lower.push(p);
        }

        let upper = [];
        for (let p of points.reverse()) {
            while (upper.length >= 2 && cross(upper[upper.length - 2], upper[upper.length - 1], p) < 0) {
                upper.pop();
            }
            upper.push(p);
        }

        return lower.concat(upper.slice(1, -1));
    };

    return convexHull(trees);
}