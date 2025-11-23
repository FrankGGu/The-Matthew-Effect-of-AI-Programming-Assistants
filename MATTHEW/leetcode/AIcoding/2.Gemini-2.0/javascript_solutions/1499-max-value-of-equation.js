var findMaxValueOfEquation = function(points, k) {
    let maxVal = -Infinity;
    const queue = [];

    for (const [x, y] of points) {
        while (queue.length > 0 && x - queue[0][0] > k) {
            queue.shift();
        }

        if (queue.length > 0) {
            maxVal = Math.max(maxVal, x + y + queue[0][1]);
        }

        while (queue.length > 0 && y - x >= queue[queue.length - 1][1] - queue[queue.length - 1][0]) {
            queue.pop();
        }

        queue.push([x, y]);
    }

    return maxVal;
};