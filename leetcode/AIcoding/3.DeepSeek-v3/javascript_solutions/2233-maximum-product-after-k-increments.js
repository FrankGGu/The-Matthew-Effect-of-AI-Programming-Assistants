var maximumProduct = function(nums, k) {
    const MOD = 1e9 + 7;
    const minHeap = new MinPriorityQueue();
    for (const num of nums) {
        minHeap.enqueue(num);
    }
    for (let i = 0; i < k; i++) {
        const smallest = minHeap.dequeue().element;
        minHeap.enqueue(smallest + 1);
    }
    let product = 1;
    while (!minHeap.isEmpty()) {
        const num = minHeap.dequeue().element;
        product = (product * num) % MOD;
    }
    return product;
};