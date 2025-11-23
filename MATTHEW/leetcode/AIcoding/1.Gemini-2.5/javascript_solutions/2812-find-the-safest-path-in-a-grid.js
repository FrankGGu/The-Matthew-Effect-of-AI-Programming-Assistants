var maximumSafenessFactor = function(grid) {
    const N = grid.length;
    const dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    // Step 1: Pre-compute minimum Manhattan distance to any thief for all cells
    const distToThief = Array(N).fill(0).map(() => Array(N).fill(Infinity));
    const q = []; // Multi-source BFS queue

    for (let r = 0; r < N; r++) {
        for (let c = 0; c < N; c++) {
            if (grid[r][c] === 1) {
                distToThief[r][c] = 0;
                q.push([r, c]);
            }
        }
    }

    let head = 0;
    while (head < q.length) {
        const [r, c] = q[head++];
        for (const [dr, dc] of dirs) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < N && nc >= 0 && nc < N && distToThief[nr][nc] === Infinity) {
                distToThief[nr][nc] = distToThief[r][c] + 1;
                q.push([nr, nc]);
            }
        }
    }

    // Step 2: Binary search on the safeness factor (minimum distance)
    let low = 0;
    // The maximum possible Manhattan distance in an N x N grid is roughly 2*N-2.
    // 2*N is a safe upper bound for the binary search.
    let high = 2 * N; 
    let ans = 0;

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

    // Helper function to check if a path exists from (0,0) to (N-1,N-1)
    // such that all cells on the path have distToThief >= minDist.
    function check(minDist) {
        // If start or end cell itself has a safeness factor less than minDist, no path is possible
        if (distToThief[0][0] < minDist || distToThief[N - 1][N - 1] < minDist) {
            return false;
        }

        const qCheck = [[0, 0]];
        const visited = Array(N).fill(0).map(() => Array(N).fill(false));
        visited[0][0] = true;
        let headCheck = 0;

        while (headCheck < qCheck.length) {
            const [r, c] = qCheck[headCheck++];
            if (r === N - 1 && c === N - 1) {
                return true;
            }

            for (const [dr, dc] of dirs) {
                const nr = r + dr;
                const nc = c + dc;

                if (nr >= 0 && nr < N && nc >= 0 && nc < N && !visited[nr][nc] && distToThief[nr][nc] >= minDist) {
                    visited[nr][nc] = true;
                    qCheck.push([nr, nc]);
                }
            }
        }
        return false;
    }
};