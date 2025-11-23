function findMaxValueOfEquation(points, k) {
    let maxVal = -Infinity;
    let queue = [];

    for (let [x, y] of points) {
        while (queue.length > 0 && queue[0][0] < x - k) {
            queue.shift();
        }

        if (queue.length > 0) {
            const [prevX, prevY] = queue[0];
            maxVal = Math.max(maxVal, prevY + prevX + x - prevX);
        }

        while (queue.length > 0 && queue[queue.length - 1][1] <= y - x) {
            queue.pop();
        }

        queue.push([x, y - x]);
    }

    return maxVal;
}