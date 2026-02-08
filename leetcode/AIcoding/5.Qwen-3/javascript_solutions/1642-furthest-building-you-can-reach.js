function furthestBuilding(heights, bricks, ladders) {
    const minHeap = [];

    for (let i = 0; i < heights.length - 1; i++) {
        const diff = heights[i + 1] - heights[i];
        if (diff > 0) {
            minHeap.push(diff);
            if (minHeap.length > ladders) {
                bricks -= minHeap.shift();
            }
        }

        if (bricks < 0) {
            return i;
        }
    }

    return heights.length - 1;
}