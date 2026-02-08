var maximumMinutes = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const INF = Infinity;

    const dx = [0, 0, 1, -1];
    const dy = [1, -1, 0, 0];

    // Step 1: Calculate fire spread times for every cell
    const fireTime = Array(m).fill(0).map(() => Array(n).fill(INF));
    const fireQueue = []; // [r, c, time]

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) { // Initial fire
                fireQueue.push([r, c, 0]);
                fireTime[r][c] = 0;
            }
        }
    }

    let head = 0;
    while (head < fireQueue.length) {
        const [r, c, time] = fireQueue[head++];

        for (let i = 0; i < 4; i++) {
            const nr = r + dx[i];
            const nc = c + dy[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 2 && fireTime[nr][nc] === INF) {
                fireTime[nr][nc] = time + 1;
                fireQueue.push([nr, nc, time + 1]);
            }
        }
    }

    // Helper function to check if it's possible to reach the exit given a waitTime
    const check = (waitTime) => {
        // If fire reaches the starting cell (0,0) at or before waitTime, it's impossible to start.
        if (fireTime[0][0] <= waitTime) {
            return false;
        }

        const personQueue = [[0, 0, waitTime]]; // [r, c, current_time]
        const visited = Array(m).fill(0).map(() => Array(n).fill(false));
        visited[0][0] = true;

        let personHead = 0;
        while (personHead < personQueue.length) {
            const [r, c, time] = personQueue[personHead++];

            // If we reached the exit (m-1, n-1)
            if (r === m - 1 && c === n - 1) {
                return true;
            }

            for (let i = 0; i < 4; i++) {
                const nr = r + dx[i];
                const nc = c + dy[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 2 && !visited[nr][nc]) {
                    const nextPersonTime = time + 1;

                    // Special handling for the exit cell:
                    // Person can enter the exit cell at the same time fire reaches it.
                    // For all other cells, person must arrive strictly before fire.
                    if (nr === m - 1 && nc === n - 1) {
                        if (nextPersonTime <= fireTime[nr][nc]) {
                            return true;
                        }
                    } else if (nextPersonTime < fireTime[nr][nc]) {
                        visited[nr][nc] = true;
                        personQueue.push([nr, nc, nextPersonTime]);
                    }
                }
            }
        }
        return false;
    };

    // Step 2: Binary Search for the maximum wait_time
    let low = 0;
    // A sufficiently large number for "indefinitely". 10^9 is specified in problem description.
    let high = 10**9; 
    let ans = -1;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};