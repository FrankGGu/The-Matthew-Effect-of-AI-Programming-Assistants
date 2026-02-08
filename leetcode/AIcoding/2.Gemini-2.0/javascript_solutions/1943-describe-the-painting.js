var splitPainting = function(segments) {
    const events = {};
    for (const [start, end, color] of segments) {
        if (!events[start]) {
            events[start] = 0;
        }
        events[start] += color;
        if (!events[end]) {
            events[end] = 0;
        }
        events[end] -= color;
    }

    const positions = Object.keys(events).map(Number).sort((a, b) => a - b);
    const result = [];
    let currentColor = 0;
    let start = positions[0];

    for (let i = 0; i < positions.length - 1; i++) {
        currentColor += events[positions[i]];
        if (currentColor > 0) {
            result.push([positions[i], positions[i + 1], currentColor]);
        }
    }

    return result;
};