var minimumDifference = function(nums) {
    const n = nums.length / 3;
    const leftMin = new Array(3 * n).fill(0);
    const rightMax = new Array(3 * n).fill(0);

    const maxHeap = new MaxPriorityQueue();
    let sum = 0;
    for (let i = 0; i < 2 * n; i++) {
        maxHeap.enqueue(nums[i]);
        sum += nums[i];
        if (maxHeap.size() > n) {
            sum -= maxHeap.dequeue().element;
        }
        leftMin[i] = sum;
    }

    const minHeap = new MinPriorityQueue();
    sum = 0;
    for (let i = 3 * n - 1; i >= n; i--) {
        minHeap.enqueue(nums[i]);
        sum += nums[i];
        if (minHeap.size() > n) {
            sum -= minHeap.dequeue().element;
        }
        rightMax[i] = sum;
    }

    let res = Infinity;
    for (let i = n - 1; i < 2 * n; i++) {
        res = Math.min(res, leftMin[i] - rightMax[i + 1]);
    }

    return res;
};