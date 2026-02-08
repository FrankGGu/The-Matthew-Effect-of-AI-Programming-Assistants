var cycleLengthQueries = function(n, queries) {
    const parent = new Array(n + 1).fill(0).map((_, i) => i === 0 ? 0 : Math.floor(i / 2));
    const getCycleLength = (x, y) => {
        const pathX = [];
        const pathY = [];
        while (x > 0) {
            pathX.push(x);
            x = parent[x];
        }
        while (y > 0) {
            pathY.push(y);
            y = parent[y];
        }
        let i = pathX.length - 1;
        let j = pathY.length - 1;
        while (i >= 0 && j >= 0 && pathX[i] === pathY[j]) {
            i--;
            j--;
        }
        return (pathX.length - 1 - i) + (pathY.length - 1 - j) + 1;
    };

    return queries.map(([x, y]) => getCycleLength(x, y));
};