var minGroups = function(intervals) {
    intervals.sort((a, b) => a[0] - b[0]);
    let heap = new MinPriorityQueue();
    for (let [start, end] of intervals) {
        if (heap.size() > 0 && heap.front().element < start) {
            heap.dequeue();
        }
        heap.enqueue(end);
    }
    return heap.size();
};