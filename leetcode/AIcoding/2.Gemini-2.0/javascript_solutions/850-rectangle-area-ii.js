var rectangleArea = function(rectangles) {
    let events = [];
    for (let rect of rectangles) {
        events.push([rect[0], 0, rect]);
        events.push([rect[2], 1, rect]);
    }

    events.sort((a, b) => a[0] - b[0]);

    let active = [];
    let area = 0;
    let prevX = events[0][0];
    const MOD = 10**9 + 7;

    for (let event of events) {
        let x = event[0];
        let type = event[1];
        let rect = event[2];

        let width = x - prevX;
        let height = 0;

        active.sort((a, b) => a[1] - b[1]);

        let prevY = -Infinity;
        for (let act of active) {
            let y1 = Math.max(act[1], prevY);
            let y2 = act[3];
            if (y1 < y2) {
                height += (y2 - y1);
                prevY = y2;
            }
        }

        area = (area + (width * height)) % MOD;
        prevX = x;

        if (type === 0) {
            active.push(rect);
        } else {
            active = active.filter(r => r !== rect);
        }
    }

    return area;
};