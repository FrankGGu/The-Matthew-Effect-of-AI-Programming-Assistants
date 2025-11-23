var minOperations = function(nums, k) {
    const minHeap = new MinPriorityQueue();
    for (const num of nums) {
        minHeap.enqueue(num);
    }

    let operations = 0;

    while (minHeap.size() > 1 && minHeap.front().element < k) {
        const first = minHeap.dequeue().element;
        const second = minHeap.dequeue().element;
        const newNum = Math.min(first, second) * 2 + Math.max(first, second);
        minHeap.enqueue(newNum);
        operations++;
    }

    return operations;
};