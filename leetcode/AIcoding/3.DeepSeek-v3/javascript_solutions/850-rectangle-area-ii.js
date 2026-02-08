var rectangleArea = function(rectangles) {
    const MOD = 1e9 + 7;
    let events = [];
    for (let [x1, y1, x2, y2] of rectangles) {
        events.push([y1, 1, x1, x2]);
        events.push([y2, -1, x1, x2]);
    }
    events.sort((a, b) => a[0] - b[0]);

    let active = [];
    let res = 0;
    let prevY = events[0][0];

    for (let [y, typ, x1, x2] of events) {
        let query = 0;
        let cur = -1;
        for (let [a, b] of active) {
            cur = Math.max(cur, a);
            query += Math.max(0, b - cur);
            cur = Math.max(cur, b);
        }
        res += query * (y - prevY);
        res %= MOD;

        if (typ === 1) {
            active.push([x1, x2]);
            active.sort((a, b) => a[0] - b[0]);
        } else {
            for (let i = 0; i < active.length; i++) {
                if (active[i][0] === x1 && active[i][1] === x2) {
                    active.splice(i, 1);
                    break;
                }
            }
        }
        prevY = y;
    }
    return res;
};