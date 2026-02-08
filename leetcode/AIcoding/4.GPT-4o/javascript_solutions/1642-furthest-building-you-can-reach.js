var furthestBuilding = function(heights, bricks, ladders) {
    const pq = new MinPriorityQueue();
    for (let i = 0; i < heights.length - 1; i++) {
        const diff = heights[i + 1] - heights[i];
        if (diff > 0) {
            pq.enqueue(diff);
        }
        if (pq.size() > ladders) {
            bricks -= pq.dequeue().element;
        }
        if (bricks < 0) {
            return i;
        }
    }
    return heights.length - 1;
};