class Solution {
    minInterval(intervals, queries) {
        intervals.sort((a, b) => a[0] - b[0]);
        const sortedQueries = queries.map((q, index) => [q, index]).sort((a, b) => a[0] - b[0]);
        const result = new Array(queries.length).fill(0);
        const minHeap = new MinPriorityQueue({ priority: x => x[1] });
        let i = 0;

        for (const [query, idx] of sortedQueries) {
            while (i < intervals.length && intervals[i][0] <= query) {
                minHeap.enqueue([intervals[i][0], intervals[i][1]]);
                i++;
            }
            while (minHeap.size() > 0 && minHeap.front()[1] < query) {
                minHeap.dequeue();
            }
            if (minHeap.size() > 0) {
                result[idx] = minHeap.front()[1] - minHeap.front()[0] + 1;
            } else {
                result[idx] = -1;
            }
        }
        return result;
    }
}