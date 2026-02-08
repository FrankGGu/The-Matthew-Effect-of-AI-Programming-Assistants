var distinctColors = function(n, queries) {
    let colorCount = new Map();
    let balls = new Array(n).fill(0);
    let result = [];

    for (let [index, color] of queries) {
        if (balls[index] !== 0) {
            let oldColor = balls[index];
            colorCount.set(oldColor, (colorCount.get(oldColor) || 0) - 1);
            if (colorCount.get(oldColor) === 0) {
                colorCount.delete(oldColor);
            }
        }

        balls[index] = color;
        colorCount.set(color, (colorCount.get(color) || 0) + 1);
        result.push(colorCount.size);
    }

    return result;
};