var minimumTime = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    if (grid[0][1] > 1 && grid[1][0] > 1) {
        return -1;
    }

    const dist = Array(m).fill(null).map(() => Array(n).fill(Infinity));
    dist[0][0] = 0;

    const pq = [[0, 0, 0]]; // [time, row, col]

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [time, row, col] = pq.shift();

        if (time > dist[row][col]) {
            continue;
        }

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                let waitTime = 0;
                if (grid[newRow][newCol] > time + 1) {
                    waitTime = grid[newRow][newCol] - (time + 1);
                    if (waitTime % 2 === 0) {
                        waitTime++;
                    } else {
                        waitTime = grid[newRow][newCol] - (time + 1);
                    }
                }

                const newTime = time + 1 + waitTime;

                if (newTime < dist[newRow][newCol]) {
                    dist[newRow][newCol] = newTime;
                    pq.push([newTime, newRow, newCol]);
                }
            }
        }
    }

    return dist[m - 1][n - 1] === Infinity ? -1 : dist[m - 1][n - 1];
};