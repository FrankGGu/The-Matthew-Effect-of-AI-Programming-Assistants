var maxKelements = function(nums, k) {
    const maxHeap = new MaxPriorityQueue();
    for (const num of nums) {
        maxHeap.enqueue(num);
    }
    let score = 0;
    for (let i = 0; i < k; i++) {
        const max = maxHeap.dequeue().element;
        score += max;
        const newNum = Math.ceil(max / 3);
        maxHeap.enqueue(newNum);
    }
    return score;
};