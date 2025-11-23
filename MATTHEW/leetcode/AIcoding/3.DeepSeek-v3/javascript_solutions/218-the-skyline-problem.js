var getSkyline = function(buildings) {
    const points = [];
    for (const [left, right, height] of buildings) {
        points.push([left, height, 'start']);
        points.push([right, -height, 'end']);
    }

    points.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            if (a[2] !== b[2]) {
                return a[2] === 'start' ? -1 : 1;
            } else {
                if (a[2] === 'start') {
                    return b[1] - a[1];
                } else {
                    return a[1] - b[1];
                }
            }
        }
    });

    const result = [];
    const maxHeap = new MaxPriorityQueue();
    maxHeap.enqueue(0);
    let prevMax = 0;

    for (const [x, h, type] of points) {
        if (type === 'start') {
            maxHeap.enqueue(h);
        } else {
            maxHeap.delete(-h);
        }

        const currentMax = maxHeap.front()?.element || 0;
        if (currentMax !== prevMax) {
            result.push([x, currentMax]);
            prevMax = currentMax;
        }
    }

    return result;
};