var findMinimumCost = function(nums) {
    let minCost = 0;
    let heap = new MinPriorityQueue();

    for (let num of nums) {
        heap.enqueue(num);
    }

    while (heap.size() > 1) {
        let first = heap.dequeue().element;
        let second = heap.dequeue().element;
        let sum = first + second;
        minCost += sum;
        heap.enqueue(sum);
    }

    return minCost;
};