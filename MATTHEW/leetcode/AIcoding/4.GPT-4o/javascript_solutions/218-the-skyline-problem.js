var getSkyline = function(buildings) {
    const events = [];
    for (const [left, right, height] of buildings) {
        events.push([left, -height]);
        events.push([right, height]);
    }
    events.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        return a[1] - b[1];
    });

    const result = [];
    const heights = new Map();
    let prevMaxHeight = 0;

    for (const [pos, h] of events) {
        if (h < 0) {
            heights.set(-h, (heights.get(-h) || 0) + 1);
        } else {
            if (heights.get(h) === 1) {
                heights.delete(h);
            } else {
                heights.set(h, heights.get(h) - 1);
            }
        }

        const currentMaxHeight = heights.size > 0 ? Math.max(...heights.keys()) : 0;
        if (currentMaxHeight !== prevMaxHeight) {
            result.push([pos, currentMaxHeight]);
            prevMaxHeight = currentMaxHeight;
        }
    }

    return result;
};