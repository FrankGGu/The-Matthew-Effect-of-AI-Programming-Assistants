var minInterval = function(intervals, queries) {
    intervals.sort((a, b) => a[0] - b[0]);
    const sortedQueries = queries.map((q, i) => [q, i]).sort((a, b) => a[0] - b[0]);
    const minHeap = new MinPriorityQueue({ priority: (el) => el[0] });
    const res = new Array(queries.length).fill(-1);
    let i = 0;

    for (const [query, index] of sortedQueries) {
        while (i < intervals.length && intervals[i][0] <= query) {
            const [start, end] = intervals[i];
            const size = end - start + 1;
            minHeap.enqueue([size, end]);
            i++;
        }

        while (minHeap.size() > 0 && minHeap.front().element[1] < query) {
            minHeap.dequeue();
        }

        if (minHeap.size() > 0) {
            res[index] = minHeap.front().element[0];
        }
    }

    return res;
};