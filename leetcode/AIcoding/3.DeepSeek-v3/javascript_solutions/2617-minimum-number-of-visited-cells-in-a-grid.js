var minimumVisitedCells = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dist = new Array(m).fill().map(() => new Array(n).fill(Infinity));
    dist[0][0] = 1;

    const rowHeaps = new Array(m).fill().map(() => new MinPriorityQueue());
    const colHeaps = new Array(n).fill().map(() => new MinPriorityQueue());

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            while (!rowHeaps[i].isEmpty() && rowHeaps[i].front().element[1] + grid[i][rowHeaps[i].front().element[1]] < j) {
                rowHeaps[i].dequeue();
            }
            if (!rowHeaps[i].isEmpty()) {
                dist[i][j] = Math.min(dist[i][j], dist[i][rowHeaps[i].front().element[1]] + 1);
            }

            while (!colHeaps[j].isEmpty() && colHeaps[j].front().element[0] + grid[colHeaps[j].front().element[0]][j] < i) {
                colHeaps[j].dequeue();
            }
            if (!colHeaps[j].isEmpty()) {
                dist[i][j] = Math.min(dist[i][j], dist[colHeaps[j].front().element[0]][j] + 1);
            }

            if (dist[i][j] !== Infinity) {
                rowHeaps[i].enqueue([i, j], dist[i][j]);
                colHeaps[j].enqueue([i, j], dist[i][j]);
            }
        }
    }

    return dist[m - 1][n - 1] === Infinity ? -1 : dist[m - 1][n - 1];
};