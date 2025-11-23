var maxManhattanDistance = function(points, k) {
    let max1 = -Infinity, min1 = Infinity;
    let max2 = -Infinity, min2 = Infinity;

    for (let [x, y] of points) {
        max1 = Math.max(max1, x + y);
        min1 = Math.min(min1, x + y);
        max2 = Math.max(max2, x - y);
        min2 = Math.min(min2, x - y);
    }

    let ans = 0;
    for (let [x, y] of points) {
        ans = Math.max(ans, Math.max(Math.abs(x + y - max1), Math.abs(x + y - min1), Math.abs(x - y - max2), Math.abs(x - y - min2)) - k);
    }

    return ans;
};