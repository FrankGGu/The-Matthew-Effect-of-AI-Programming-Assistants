var maximumProduct = function(nums, k) {
    const MOD = 10**9 + 7;
    const pq = new MinPriorityQueue({ priority: x => x });

    for (const num of nums) {
        pq.enqueue(num);
    }

    for (let i = 0; i < k; i++) {
        const min = pq.dequeue().element;
        pq.enqueue(min + 1);
    }

    let product = 1;
    while (!pq.isEmpty()) {
        product = (product * pq.dequeue().element) % MOD;
    }

    return product;
};