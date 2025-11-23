var maximumMinutes = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    // Step 1: Calculate fire spread times
    const fireTime = Array(m).fill(0).map(() => Array(n).fill(Infinity));
    const qFire = [];

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                qFire.push([r, c, 0]);
                fireTime[r][c] = 0;
            }
        }
    }

    let headFire = 0;
    while (headFire < qFire.length) {
        const [r, c, time] = qFire[headFire++];

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 2 && fireTime[nr][nc] === Infinity) {
                fireTime[nr][nc] = time + 1;
                qFire.push([nr, nc, time + 1]);
            }
        }
    }

    // Step 2: Binary search for the maximum wait_time
    let low = 0;
    let high = 10**9; // A sufficiently large upper bound for wait_time
    let ans = -1;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (canEscape(mid, m, n, grid, fireTime, dr, dc)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;

    // Helper function to check if escape is possible with a given wait_time
    function canEscape(wait_time, m, n, grid, fireTime, dr, dc) {
        // If fire reaches the starting cell (0,0) at or before the person starts, escape is impossible.
        if (fireTime[0][0] <= wait_time) {
            return false;
        }

        const qPerson = [[0, 0, wait_time]]; // [row, col, current_time]
        const visited = Array(m).fill(0).map(() => Array(n).fill(false));
        visited[0][0] = true;

        let headPerson = 0;
        while (headPerson < qPerson.length) {
            const [r, c, time] = qPerson[headPerson++];

            if (r === m - 1 && c === n - 1) {
                return true; // Reached target
            }

            for (let i = 0; i < 4; i++) {
                const nr = r + dr[i];
                const nc = c + dc[i];
                const nextTime = time + 1;

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] !== 2 && !visited[nr][nc]) {
                    // Person arrives at (nr, nc) at nextTime. Fire arrives at fireTime[nr][nc].
                    // Person is safe if:
                    // 1. nextTime < fireTime[nr][nc] (person arrives strictly before fire)
                    // 2. (nr, nc) is the target cell AND nextTime <= fireTime[nr][nc]
                    //    (person arrives at target at or before fire, implying escape)
                    if (nextTime < fireTime[nr][nc] || (nr === m - 1 && nc === n - 1 && nextTime <= fireTime[nr][nc])) {
                        visited[nr][nc] = true;
                        qPerson.push([nr, nc, nextTime]);
                    }
                }
            }
        }
        return false;
    }
};