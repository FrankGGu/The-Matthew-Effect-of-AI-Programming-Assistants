var maxPoints = function(grid, queries) {
    const m = grid.length;
    const n = grid[0].length;
    const k = queries.length;
    const sortedQueries = queries.map((val, idx) => [val, idx]).sort((a, b) => a[0] - b[0]);
    const result = new Array(k).fill(0);
    const minHeap = new MinPriorityQueue({ priority: (elem) => elem[0] });
    const visited = new Array(m).fill().map(() => new Array(n).fill(false));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    minHeap.enqueue([grid[0][0], 0, 0]);
    visited[0][0] = true;
    let count = 0;

    for (const [query, idx] of sortedQueries) {
        while (!minHeap.isEmpty() && minHeap.front().element[0] < query) {
            const [val, i, j] = minHeap.dequeue().element;
            count++;

            for (const [di, dj] of directions) {
                const ni = i + di;
                const nj = j + dj;
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                    visited[ni][nj] = true;
                    minHeap.enqueue([grid[ni][nj], ni, nj]);
                }
            }
        }
        result[idx] = count;
    }

    return result;
};