var minInterval = function(intervals, queries) {
    intervals.sort((a, b) => a[0] - b[0]);
    const queryIndices = queries.map((q, i) => i).sort((a, b) => queries[a] - queries[b]);
    const result = new Array(queries.length).fill(-1);
    const minHeap = [];

    let i = 0;
    for (const queryIndex of queryIndices) {
        const query = queries[queryIndex];

        while (i < intervals.length && intervals[i][0] <= query) {
            const [start, end] = intervals[i];
            const intervalSize = end - start + 1;
            minHeap.push([intervalSize, start, end]);
            minHeap.sort((a, b) => a[0] - b[0]);
            i++;
        }

        while (minHeap.length > 0 && minHeap[0][2] < query) {
            minHeap.shift();
        }

        if (minHeap.length > 0 && minHeap[0][1] <= query && minHeap[0][2] >= query) {
            result[queryIndex] = minHeap[0][0];
        }
    }

    return result;
};