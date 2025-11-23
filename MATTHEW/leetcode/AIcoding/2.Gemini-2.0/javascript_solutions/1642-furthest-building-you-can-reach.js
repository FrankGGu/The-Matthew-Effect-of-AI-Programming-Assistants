var furthestBuilding = function(heights, bricks, ladders) {
    const pq = [];

    for (let i = 0; i < heights.length - 1; i++) {
        const diff = heights[i + 1] - heights[i];
        if (diff > 0) {
            pq.push(diff);
            pq.sort((a, b) => b - a);

            if (pq.length > ladders) {
                bricks -= pq.pop();
                if (bricks < 0) {
                    return i;
                }
            }
        }
    }

    return heights.length - 1;
};