var outerTrees = function(trees) {
    if (trees.length <= 1) return trees;

    trees.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    const cross = (o, a, b) => {
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
    };

    let lower = [];
    for (let tree of trees) {
        while (lower.length >= 2 && cross(lower[lower.length - 2], lower[lower.length - 1], tree) < 0) {
            lower.pop();
        }
        lower.push(tree);
    }

    let upper = [];
    for (let i = trees.length - 1; i >= 0; i--) {
        while (upper.length >= 2 && cross(upper[upper.length - 2], upper[upper.length - 1], trees[i]) < 0) {
            upper.pop();
        }
        upper.push(trees[i]);
    }

    let res = [...lower, ...upper];
    let unique = new Set();
    let final = [];
    for (let point of res) {
        let key = point[0] + ',' + point[1];
        if (!unique.has(key)) {
            unique.add(key);
            final.push(point);
        }
    }

    return final;
};