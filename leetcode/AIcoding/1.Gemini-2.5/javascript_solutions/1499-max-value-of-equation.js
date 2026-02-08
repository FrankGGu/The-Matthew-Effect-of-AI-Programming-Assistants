var findMaxValueOfEquation = function(points, k) {
    let maxVal = -Infinity;
    const dq = []; // Stores indices of points

    for (let j = 0; j < points.length; j++) {
        const xj = points[j][0];
        const yj = points[j][1];

        while (dq.length > 0 && points[dq[0]][0] < xj - k) {
            dq.shift();
        }

        if (dq.length > 0) {
            const i = dq[0];
            const xi = points[i][0];
            const yi = points[i][1];
            maxVal = Math.max(maxVal, (yi - xi) + (yj + xj));
        }

        while (dq.length > 0 && (points[dq[dq.length - 1]][1] - points[dq[dq.length - 1]][0]) <= (yj - xj)) {
            dq.pop();
        }

        dq.push(j);
    }

    return maxVal;
};