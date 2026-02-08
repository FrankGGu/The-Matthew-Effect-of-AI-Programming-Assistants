var getMinDistSum = function(positions) {
    let n = positions.length;
    let x = 0, y = 0;
    for (let pos of positions) {
        x += pos[0];
        y += pos[1];
    }
    x /= n;
    y /= n;

    let dist = (a, b) => Math.sqrt((a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2);
    let cost = (p) => {
        let sum = 0;
        for (let pos of positions) {
            sum += dist(pos, p);
        }
        return sum;
    }

    let learningRate = 0.1;
    for (let i = 0; i < 100; i++) {
        let dx = 0, dy = 0;
        for (let pos of positions) {
            let d = dist(pos, [x, y]);
            if (d > 0) {
                dx += (pos[0] - x) / d;
                dy += (pos[1] - y) / d;
            }
        }
        x += learningRate * dx;
        y += learningRate * dy;
        learningRate *= 0.99;
    }

    let finalCost = 0;
    for (let pos of positions) {
        finalCost += dist(pos, [x, y]);
    }
    return Math.round(finalCost);
};