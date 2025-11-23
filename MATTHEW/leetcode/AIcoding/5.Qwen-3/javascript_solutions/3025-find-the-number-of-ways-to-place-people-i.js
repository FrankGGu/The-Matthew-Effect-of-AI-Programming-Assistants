function numberOfWaysPeopleCanPlace(positions) {
    const n = positions.length;
    const xMap = new Map();
    const yMap = new Map();

    for (const [x, y] of positions) {
        if (!xMap.has(x)) xMap.set(x, 0);
        xMap.set(x, xMap.get(x) + 1);

        if (!yMap.has(y)) yMap.set(y, 0);
        yMap.set(y, yMap.get(y) + 1);
    }

    let result = 0;

    for (const [x, countX] of xMap) {
        for (const [y, countY] of yMap) {
            let same = 0;
            for (const [px, py] of positions) {
                if (px === x && py === y) same++;
            }
            result += (countX - same) * (countY - same);
        }
    }

    return result;
}