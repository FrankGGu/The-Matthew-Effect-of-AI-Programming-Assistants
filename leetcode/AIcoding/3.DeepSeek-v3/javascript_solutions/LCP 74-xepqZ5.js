var fieldOfGreatestBlessing = function(forceField) {
    let events = [];
    for (let [x, y, side] of forceField) {
        let x1 = x - side / 2;
        let x2 = x + side / 2;
        let y1 = y - side / 2;
        let y2 = y + side / 2;
        events.push([x1, y1, y2, 1]);
        events.push([x2, y1, y2, -1]);
    }
    events.sort((a, b) => a[0] - b[0] || a[3] - b[3]);

    let active = [];
    let res = 0;
    let prevX = null;
    for (let [x, y1, y2, typ] of events) {
        if (prevX !== null && x !== prevX) {
            active.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
            let cnt = 0;
            let start = null;
            let maxCnt = 0;
            let current = 0;
            let intervals = [];
            for (let [a, b, t] of active) {
                if (t === 1) {
                    current++;
                    if (current > maxCnt) {
                        maxCnt = current;
                        intervals = [[a, b]];
                    } else if (current === maxCnt) {
                        intervals.push([a, b]);
                    }
                } else {
                    current--;
                }
            }
            let merged = [];
            if (intervals.length > 0) {
                intervals.sort((a, b) => a[0] - b[0]);
                merged.push([...intervals[0]]);
                for (let i = 1; i < intervals.length; i++) {
                    let last = merged[merged.length - 1];
                    let curr = intervals[i];
                    if (curr[0] <= last[1]) {
                        last[1] = Math.max(last[1], curr[1]);
                    } else {
                        merged.push([...curr]);
                    }
                }
            }
            let total = 0;
            for (let [a, b] of merged) {
                total += b - a;
            }
            res = Math.max(res, maxCnt * total * (x - prevX));
        }
        if (typ === 1) {
            active.push([y1, y2, 1]);
            active.push([y2, y2, -1]);
        } else {
            active = active.filter(([a, b, t]) => !(a === y1 && b === y2 && t === 1));
            active = active.filter(([a, b, t]) => !(a === y2 && b === y2 && t === -1));
        }
        prevX = x;
    }
    return res;
};