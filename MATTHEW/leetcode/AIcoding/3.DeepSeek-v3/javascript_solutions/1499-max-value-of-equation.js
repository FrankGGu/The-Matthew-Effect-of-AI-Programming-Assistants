var findMaxValueOfEquation = function(points, k) {
    let max = -Infinity;
    let deque = [];
    for (let j = 0; j < points.length; j++) {
        const [xj, yj] = points[j];
        while (deque.length > 0 && xj - points[deque[0]][0] > k) {
            deque.shift();
        }
        if (deque.length > 0) {
            const i = deque[0];
            const [xi, yi] = points[i];
            max = Math.max(max, yi + yj + xj - xi);
        }
        while (deque.length > 0) {
            const last = deque[deque.length - 1];
            const [xl, yl] = points[last];
            if (yj - xj >= yl - xl) {
                deque.pop();
            } else {
                break;
            }
        }
        deque.push(j);
    }
    return max;
};