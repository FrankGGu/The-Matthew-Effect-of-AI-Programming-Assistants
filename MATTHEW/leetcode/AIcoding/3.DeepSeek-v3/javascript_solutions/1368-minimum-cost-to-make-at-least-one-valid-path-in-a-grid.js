var minCost = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    const heap = new MinPriorityQueue({ priority: (x) => x[0] });
    heap.enqueue([0, 0, 0]);
    const visited = new Array(m).fill().map(() => new Array(n).fill(Infinity));

    while (!heap.isEmpty()) {
        const [cost, i, j] = heap.dequeue().element;
        if (i === m - 1 && j === n - 1) return cost;
        if (visited[i][j] <= cost) continue;
        visited[i][j] = cost;

        for (let d = 0; d < 4; d++) {
            const [di, dj] = dirs[d];
            const ni = i + di;
            const nj = j + dj;
            if (ni < 0 || nj < 0 || ni >= m || nj >= n) continue;
            const newCost = cost + (d + 1 === grid[i][j] ? 0 : 1);
            if (newCost < visited[ni][nj]) {
                heap.enqueue([newCost, ni, nj]);
            }
        }
    }
    return -1;
};