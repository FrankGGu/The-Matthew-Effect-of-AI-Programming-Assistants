var outerTrees = function(trees) {
    const n = trees.length;

    if (n <= 2) {
        return trees;
    }

    trees.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    function crossProduct(p1, p2, p3) {
        return (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0]);
    }

    const lower = [];
    for (const p of trees) {
        while (lower.length >= 2 && crossProduct(lower[lower.length - 2], lower[lower.length - 1], p) < 0) {
            lower.pop();
        }
        lower.push(p);
    }

    const upper = [];
    for (let i = n - 1; i >= 0; i--) {
        const p = trees[i];
        while (upper.length >= 2 && crossProduct(upper[upper.length - 2], upper[upper.length - 1], p) < 0) {
            upper.pop();
        }
        upper.push(p);
    }

    const result = new Set();
    for (const p of lower) {
        result.add(`${p[0]},${p[1]}`);
    }
    for (const p of upper) {
        result.add(`${p[0]},${p[1]}`);
    }

    return Array.from(result).map(s => s.split(',').map(Number));
};