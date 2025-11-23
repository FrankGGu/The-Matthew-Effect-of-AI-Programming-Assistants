var minimumEffortPath = function(heights) {
    const rows = heights.length;
    const cols = heights[0].length;

    const efforts = Array(rows).fill(null).map(() => Array(cols).fill(Infinity));
    efforts[0][0] = 0;

    const pq = [[0, 0, 0]]; // effort, row, col

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [effort, row, col] = pq.shift();

        if (effort > efforts[row][col]) {
            continue;
        }

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                const newEffort = Math.max(effort, Math.abs(heights[row][col] - heights[newRow][newCol]));

                if (newEffort < efforts[newRow][newCol]) {
                    efforts[newRow][newCol] = newEffort;
                    pq.push([newEffort, newRow, newCol]);
                }
            }
        }
    }

    return efforts[rows - 1][cols - 1];
};