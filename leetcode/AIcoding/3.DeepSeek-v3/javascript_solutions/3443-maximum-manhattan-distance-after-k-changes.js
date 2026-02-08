var maxManhattanDistance = function(points, k) {
    const n = points.length;
    let maxSum = -Infinity, minSum = Infinity;
    let maxDiff = -Infinity, minDiff = Infinity;

    for (const [x, y] of points) {
        const sum = x + y;
        const diff = x - y;
        maxSum = Math.max(maxSum, sum);
        minSum = Math.min(minSum, sum);
        maxDiff = Math.max(maxDiff, diff);
        minDiff = Math.min(minDiff, diff);
    }

    const possible = [
        Math.abs(maxSum - minSum),
        Math.abs(maxDiff - minDiff)
    ];

    return Math.max(...possible);
};