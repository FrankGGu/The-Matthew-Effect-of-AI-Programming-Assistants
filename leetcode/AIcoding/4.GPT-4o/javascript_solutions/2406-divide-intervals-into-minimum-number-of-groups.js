function minGroups(intervals) {
    intervals.sort((a, b) => a[0] - b[0]);
    const heap = [];

    for (const [start, end] of intervals) {
        if (heap.length && heap[0] < start) {
            heap.shift();
        }
        heap.push(end);
        heap.sort((a, b) => a - b);
    }

    return heap.length;
}