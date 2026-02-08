var findMaxValueOfEquation = function(points, k) {
    let maxVal = -Infinity;
    let deque = [];

    for (let [x, y] of points) {
        while (deque.length && x - deque[0][0] > k) {
            deque.shift();
        }
        if (deque.length) {
            maxVal = Math.max(maxVal, x + y + deque[0][1] - deque[0][0]);
        }
        while (deque.length && deque[deque.length - 1][1] - deque[deque.length - 1][0] <= y - x) {
            deque.pop();
        }
        deque.push([x, y]);
    }

    return maxVal;
};