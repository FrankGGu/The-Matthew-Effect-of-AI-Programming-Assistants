var pacificAtlantic = function(heights) {
    const m = heights.length;
    const n = heights[0].length;

    const pacificReachable = Array(m).fill(0).map(() => Array(n).fill(false));
    const atlanticReachable = Array(m).fill(0).map(() => Array(n).fill(false));

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    function dfs(r, c, reachableMatrix) {
        reachableMatrix[r][c] = true;

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && 
                !reachableMatrix[nr][nc] && heights[nr][nc] >= heights[r][c]) {
                dfs(nr, nc, reachableMatrix);
            }
        }
    }

    for (let r = 0; r < m; r++) {
        dfs(r, 0, pacificReachable);
        dfs(r, n - 1, atlanticReachable);
    }

    for (let c = 0; c < n; c++) {
        dfs(0, c, pacificReachable);
        dfs(m - 1, c, atlanticReachable);
    }

    const result = [];
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (pacificReachable[r][c] && atlanticReachable[r][c]) {
                result.push([r, c]);
            }
        }
    }

    return result;
};