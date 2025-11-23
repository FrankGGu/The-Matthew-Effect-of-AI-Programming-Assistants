function countRightTriangles(coordinates) {
    const map = new Map();
    for (const [x, y] of coordinates) {
        if (!map.has(x)) {
            map.set(x, new Map());
        }
        map.get(x).set(y, (map.get(x).get(y) || 0) + 1);
    }

    let count = 0;
    for (const [x1, y1] of coordinates) {
        for (const [x2, y2] of coordinates) {
            if (x1 === x2 || y1 === y2) continue;
            if (map.has(x1) && map.get(x1).has(y2) && map.has(x2) && map.get(x2).has(y1)) {
                count += map.get(x1).get(y2) * map.get(x2).get(y1);
            }
        }
    }
    return count;
}