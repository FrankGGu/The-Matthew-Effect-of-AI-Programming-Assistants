var minStoneSum = function(piles, k) {
    const maxHeap = new MaxPriorityQueue();
    for (let pile of piles) {
        maxHeap.enqueue(pile);
    }
    for (let i = 0; i < k; i++) {
        let largest = maxHeap.dequeue().element;
        maxHeap.enqueue(Math.floor(largest / 2));
    }
    let total = 0;
    while (maxHeap.size() > 0) {
        total += maxHeap.dequeue().element;
    }
    return total;
};