var furthestBuilding = function(heights, bricks, ladders) {
    const minHeap = new MinPriorityQueue();

    for (let i = 0; i < heights.length - 1; i++) {
        const diff = heights[i + 1] - heights[i];
        if (diff <= 0) continue;

        if (ladders > 0) {
            minHeap.enqueue(diff);
            ladders--;
        } else {
            if (minHeap.size() > 0 && diff > minHeap.front().element) {
                const smallest = minHeap.dequeue().element;
                if (bricks >= smallest) {
                    bricks -= smallest;
                    minHeap.enqueue(diff);
                } else {
                    return i;
                }
            } else {
                if (bricks >= diff) {
                    bricks -= diff;
                } else {
                    return i;
                }
            }
        }
    }

    return heights.length - 1;
};