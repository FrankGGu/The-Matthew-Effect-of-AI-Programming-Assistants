var isPossible = function(target) {
    let total = target.reduce((a, b) => a + b, 0);
    const maxHeap = new MaxPriorityQueue({ priority: x => x });

    for (const num of target) {
        maxHeap.enqueue(num);
    }

    while (true) {
        const largest = maxHeap.dequeue().element;
        total -= largest;
        if (largest === 1 || total === 1) return true;
        if (largest < total || total === 0 || largest % total === 0) return false;
        largest %= total;
        total += largest;
        maxHeap.enqueue(largest);
    }
};