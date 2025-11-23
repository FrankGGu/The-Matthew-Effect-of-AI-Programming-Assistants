var minStoneSum = function(piles, k) {
    const maxHeap = new MaxPriorityQueue();
    for (const pile of piles) {
        maxHeap.enqueue(pile);
    }

    for (let i = 0; i < k; i++) {
        if (maxHeap.isEmpty()) break;
        const current = maxHeap.dequeue().element;
        const removed = Math.floor(current / 2);
        maxHeap.enqueue(current - removed);
    }

    let total = 0;
    while (!maxHeap.isEmpty()) {
        total += maxHeap.dequeue().element;
    }

    return total;
};