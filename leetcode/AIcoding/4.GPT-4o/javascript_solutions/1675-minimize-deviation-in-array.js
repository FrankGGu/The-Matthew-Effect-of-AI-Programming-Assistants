var minimumDeviation = function(nums) {
    const maxHeap = new MaxPriorityQueue();
    let min = Infinity;

    for (let num of nums) {
        if (num % 2 === 0) {
            maxHeap.enqueue(num);
            min = Math.min(min, num);
        } else {
            maxHeap.enqueue(num * 2);
            min = Math.min(min, num * 2);
        }
    }

    let minDeviation = Infinity;

    while (maxHeap.size() > 0) {
        const max = maxHeap.dequeue().element;
        minDeviation = Math.min(minDeviation, max - min);

        if (max % 2 === 0) {
            maxHeap.enqueue(max / 2);
            min = Math.min(min, max / 2);
        } else {
            break;
        }
    }

    return minDeviation;
};