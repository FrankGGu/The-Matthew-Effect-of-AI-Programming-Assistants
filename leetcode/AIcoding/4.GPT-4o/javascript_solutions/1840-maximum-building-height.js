var maxBuilding = function(n, restrictions) {
    restrictions.push([0, 0]);
    restrictions.push([n, n - 1]);
    restrictions.sort((a, b) => a[0] - b[0]);

    let m = restrictions.length;
    for (let i = 1; i < m; i++) {
        const [x1, h1] = restrictions[i - 1];
        const [x2, h2] = restrictions[i];
        const height = Math.floor((h1 + h2 + (x2 - x1)) / 2);
        const delta = Math.min(h1 + (x2 - x1), h2);
        const max_height = Math.max(height, delta);
        restrictions[i][1] = max_height;
    }

    let maxHeight = 0;
    for (let i = 1; i < m; i++) {
        const [x1, h1] = restrictions[i - 1];
        const [x2, h2] = restrictions[i];
        const height = Math.floor((h1 + h2 + (x2 - x1)) / 2);
        maxHeight = Math.max(maxHeight, height);
    }

    return maxHeight;
};