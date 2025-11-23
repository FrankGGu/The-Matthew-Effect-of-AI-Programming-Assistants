var countRightTriangles = function(coordinates) {
    let xMap = new Map();
    let yMap = new Map();

    for (let [x, y] of coordinates) {
        xMap.set(x, (xMap.get(x) || 0) + 1);
        yMap.set(y, (yMap.get(y) || 0) + 1);
    }

    let count = 0;
    for (let [x, y] of coordinates) {
        count += (xMap.get(x) - 1) * (yMap.get(y) - 1);
    }

    return count;
};