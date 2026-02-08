var minimumDeviation = function(nums) {
    let maxHeap = new MaxPriorityQueue();
    let min = Infinity;

    for (let num of nums) {
        if (num % 2 !== 0) {
            num *= 2;
        }
        maxHeap.enqueue(num);
        min = Math.min(min, num);
    }

    let minDeviation = Infinity;

    while (true) {
        let max = maxHeap.dequeue().element;
        minDeviation = Math.min(minDeviation, max - min);

        if (max % 2 !== 0) {
            break;
        }

        max /= 2;
        min = Math.min(min, max);
        maxHeap.enqueue(max);
    }

    return minDeviation;
};