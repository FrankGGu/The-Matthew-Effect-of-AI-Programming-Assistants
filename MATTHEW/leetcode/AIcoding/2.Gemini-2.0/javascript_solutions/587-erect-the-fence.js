var outerTrees = function(trees) {
    if (trees.length <= 3) {
        return trees;
    }

    trees.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    const n = trees.length;
    const upperHull = [];
    const lowerHull = [];

    for (let i = 0; i < n; i++) {
        while (upperHull.length >= 2 && crossProduct(upperHull[upperHull.length - 2], upperHull[upperHull.length - 1], trees[i]) > 0) {
            upperHull.pop();
        }
        upperHull.push(trees[i]);
    }

    for (let i = n - 1; i >= 0; i--) {
        while (lowerHull.length >= 2 && crossProduct(lowerHull[lowerHull.length - 2], lowerHull[lowerHull.length - 1], trees[i]) > 0) {
            lowerHull.pop();
        }
        lowerHull.push(trees[i]);
    }

    const result = new Set();
    for (const point of upperHull) {
        result.add(JSON.stringify(point));
    }
    for (const point of lowerHull) {
        result.add(JSON.stringify(point));
    }

    const finalResult = [];
    for (const pointStr of result) {
        finalResult.push(JSON.parse(pointStr));
    }

    return finalResult;

    function crossProduct(p1, p2, p3) {
        return (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0]);
    }
};