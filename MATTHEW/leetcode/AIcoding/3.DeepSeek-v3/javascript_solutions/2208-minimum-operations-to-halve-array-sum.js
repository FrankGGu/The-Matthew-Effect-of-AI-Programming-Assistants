var halveArray = function(nums) {
    const maxHeap = new MaxPriorityQueue();
    let totalSum = 0;
    for (const num of nums) {
        maxHeap.enqueue(num);
        totalSum += num;
    }
    let target = totalSum / 2;
    let operations = 0;
    let reducedSum = 0;
    while (reducedSum < target) {
        const max = maxHeap.dequeue().element;
        const half = max / 2;
        reducedSum += half;
        maxHeap.enqueue(half);
        operations++;
    }
    return operations;
};