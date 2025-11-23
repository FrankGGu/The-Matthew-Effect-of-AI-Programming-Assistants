var maxKelements = function(nums, k) {
    const maxHeap = new MaxPriorityQueue();
    for (const num of nums) {
        maxHeap.enqueue(num);
    }
    let sum = 0;
    for (let i = 0; i < k; i++) {
        const max = maxHeap.dequeue().element;
        sum += max;
        maxHeap.enqueue(Math.ceil(max / 3));
    }
    return sum;
};