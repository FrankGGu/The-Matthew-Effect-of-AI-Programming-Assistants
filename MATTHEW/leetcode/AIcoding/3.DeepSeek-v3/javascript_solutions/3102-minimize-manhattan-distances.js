var minManhattanDistance = function(points) {
    const n = points.length;
    if (n === 0) return 0;

    const x = [];
    const y = [];

    for (const [xi, yi] of points) {
        x.push(xi);
        y.push(yi);
    }

    x.sort((a, b) => a - b);
    y.sort((a, b) => a - b);

    const mid = Math.floor((n - 1) / 2);
    const medianX = x[mid];
    const medianY = y[mid];

    let total = 0;
    for (const [xi, yi] of points) {
        total += Math.abs(xi - medianX) + Math.abs(yi - medianY);
    }

    return total;
};