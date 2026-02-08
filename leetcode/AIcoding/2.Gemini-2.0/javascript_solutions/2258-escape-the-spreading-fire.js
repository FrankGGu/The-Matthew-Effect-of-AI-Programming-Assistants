var maximumMinutes = function(forest) {
    const m = forest.length;
    const n = forest[0].length;

    const isSafe = (minutes) => {
        const queue = [[0, 0, minutes]];
        const visited = new Array(m).fill(null).map(() => new Array(n).fill(false));
        visited[0][0] = true;

        const fireSpread = (grid) => {
            const fireQueue = [];
            for (let i = 0; i < m; i++) {
                for (let j = 0; j < n; j++) {
                    if (grid[i][j] === 2) {
                        fireQueue.push([i, j]);
                    }
                }
            }

            const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
            while (fireQueue.length > 0) {
                const [row, col] = fireQueue.shift();
                for (const [dr, dc] of directions) {
                    const newRow = row + dr;
                    const newCol = col + dc;
                    if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] === 0) {
                        grid[newRow][newCol] = 2;
                        fireQueue.push([newRow, newCol]);
                    }
                }
            }
        };

        let tempForest = forest.map(row => [...row]);

        for(let i = 0; i < minutes; i++){
             fireSpread(tempForest);
        }

        while (queue.length > 0) {
            const [row, col, time] = queue.shift();

            if (row === m - 1 && col === n - 1) {
                return tempForest[row][col] !== 2;
            }

            const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;
                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && tempForest[newRow][newCol] === 0 && !visited[newRow][newCol]) {
                    visited[newRow][newCol] = true;
                    let nextForest = tempForest.map(row => [...row]);
                     fireSpread(nextForest);
                    if(nextForest[newRow][newCol] !== 2){
                        queue.push([newRow, newCol, time]);
                        tempForest = nextForest;
                    }

                }
            }
        }

        return false;
    };

    let left = 0;
    let right = m * n;
    let ans = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (isSafe(mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    if(ans === m * n){
        return 10**9;
    }

    return ans;
};