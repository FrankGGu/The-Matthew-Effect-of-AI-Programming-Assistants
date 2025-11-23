var minimumCost = function(nums, k, dist) {
    const n = nums.length;
    let minCost = Infinity;
    const window = [];
    let sum = 0;
    const maxHeap = new MaxPriorityQueue({ priority: x => x });
    const minHeap = new MinPriorityQueue({ priority: x => x });

    for (let i = 1; i <= dist + 1; i++) {
        window.push(nums[i]);
        sum += nums[i];
        maxHeap.enqueue(nums[i]);
    }
    if (window.length >= k - 1) {
        minCost = Math.min(minCost, sum);
    }

    for (let i = dist + 2; i < n; i++) {
        const outNum = window.shift();
        sum -= outNum;
        if (maxHeap.front() && maxHeap.front().element === outNum) {
            maxHeap.dequeue();
        } else {
            minHeap.enqueue(outNum);
        }

        const inNum = nums[i];
        window.push(inNum);
        sum += inNum;
        if (maxHeap.size() > 0 && inNum <= maxHeap.front().element) {
            maxHeap.enqueue(inNum);
        } else {
            minHeap.enqueue(inNum);
        }

        while (maxHeap.size() > k - 1) {
            const val = maxHeap.dequeue().element;
            sum -= val;
            minHeap.enqueue(val);
        }
        while (maxHeap.size() < k - 1 && minHeap.size() > 0) {
            const val = minHeap.dequeue().element;
            sum += val;
            maxHeap.enqueue(val);
        }

        if (window.length >= k - 1) {
            minCost = Math.min(minCost, sum);
        }
    }

    return minCost + nums[0];
};