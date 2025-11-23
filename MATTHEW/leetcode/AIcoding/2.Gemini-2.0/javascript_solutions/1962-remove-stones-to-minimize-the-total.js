var minStoneSum = function(piles, k) {
    const pq = new MaxPriorityQueue({ priority: x => x });

    for (const pile of piles) {
        pq.enqueue(pile);
    }

    for (let i = 0; i < k; i++) {
        const maxPile = pq.dequeue().element;
        const newPile = Math.floor(maxPile / 2);
        pq.enqueue(newPile);
    }

    let sum = 0;
    while (!pq.isEmpty()) {
        sum += pq.dequeue().element;
    }

    return sum;
};