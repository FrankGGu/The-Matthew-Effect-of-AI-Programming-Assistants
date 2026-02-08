var findScore = function(nums) {
    const n = nums.length;
    const marked = new Array(n).fill(false);
    const heap = new MinPriorityQueue({ priority: (x) => x[0] });

    for (let i = 0; i < n; i++) {
        heap.enqueue([nums[i], i]);
    }

    let score = 0;

    while (!heap.isEmpty()) {
        const [num, idx] = heap.dequeue().element;
        if (marked[idx]) continue;

        score += num;
        marked[idx] = true;
        if (idx > 0) marked[idx - 1] = true;
        if (idx < n - 1) marked[idx + 1] = true;
    }

    return score;
};