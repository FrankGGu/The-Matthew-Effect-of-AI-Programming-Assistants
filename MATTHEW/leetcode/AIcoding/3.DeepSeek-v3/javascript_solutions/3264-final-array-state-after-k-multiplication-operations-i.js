var maximumProduct = function(nums, k) {
    const MOD = 1e9 + 7;
    const heap = new MinPriorityQueue();
    for (const num of nums) {
        heap.enqueue(num);
    }
    for (let i = 0; i < k; i++) {
        const min = heap.dequeue().element;
        heap.enqueue(min + 1);
    }
    let product = 1;
    while (!heap.isEmpty()) {
        product = (product * heap.dequeue().element) % MOD;
    }
    return product;
};