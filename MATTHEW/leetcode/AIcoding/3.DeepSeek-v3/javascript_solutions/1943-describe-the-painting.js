var splitPainting = function(segments) {
    const events = [];
    for (const [start, end, color] of segments) {
        events.push([start, 'start', color]);
        events.push([end, 'end', color]);
    }
    events.sort((a, b) => a[0] - b[0] || (a[1] === 'start' ? -1 : 1));

    const result = [];
    let prevPos = null;
    let currentColor = 0;
    const activeColors = new Set();

    for (const [pos, type, color] of events) {
        if (prevPos !== null && pos !== prevPos && activeColors.size > 0) {
            if (result.length > 0 && result[result.length - 1][1] === prevPos) {
                const last = result.pop();
                currentColor = last[2] + currentColor;
                result.push([last[0], pos, currentColor]);
            } else {
                result.push([prevPos, pos, currentColor]);
            }
        }

        if (type === 'start') {
            activeColors.add(color);
            currentColor += color;
        } else {
            activeColors.delete(color);
            currentColor -= color;
        }

        prevPos = pos;
    }

    return result;
};