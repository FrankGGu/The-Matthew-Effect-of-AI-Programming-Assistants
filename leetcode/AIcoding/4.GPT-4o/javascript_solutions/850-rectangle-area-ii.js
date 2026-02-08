var rectangleArea = function(rectangles) {
    const mod = 1e9 + 7;
    const events = [];

    for (const [x1, y1, x2, y2] of rectangles) {
        events.push([x1, y1, y2, 1]);
        events.push([x2, y1, y2, -1]);
    }

    events.sort((a, b) => a[0] - b[0]);

    let prevX = 0, area = 0;
    const heights = [];

    for (const [x, y1, y2, type] of events) {
        area = (area + (x - prevX) * calculateHeight(heights)) % mod;
        prevX = x;

        if (type === 1) {
            heights.push([y1, y2]);
        } else {
            heights.splice(heights.findIndex(([h1, h2]) => h1 === y1 && h2 === y2), 1);
        }
    }

    return area;
};

function calculateHeight(heights) {
    let totalHeight = 0, prevY = -1, count = 0;
    const yEvents = [];

    for (const [y1, y2] of heights) {
        yEvents.push([y1, 1]);
        yEvents.push([y2, -1]);
    }

    yEvents.sort((a, b) => a[0] - b[0]);

    for (const [y, type] of yEvents) {
        if (count > 0) {
            totalHeight += y - prevY;
        }
        count += type;
        prevY = y;
    }

    return totalHeight;
}