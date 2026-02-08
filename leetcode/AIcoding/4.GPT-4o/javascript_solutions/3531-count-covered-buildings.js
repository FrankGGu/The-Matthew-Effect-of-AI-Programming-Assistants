function countCoveredBuildings(buildings) {
    let events = [];
    for (const [start, end] of buildings) {
        events.push([start, 1]);
        events.push([end, -1]);
    }

    events.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    let covered = 0;
    let count = 0;
    let lastPos = -1;

    for (const [pos, type] of events) {
        if (count > 0 && lastPos !== -1) {
            covered += pos - lastPos;
        }
        count += type;
        lastPos = pos;
    }

    return covered;
}