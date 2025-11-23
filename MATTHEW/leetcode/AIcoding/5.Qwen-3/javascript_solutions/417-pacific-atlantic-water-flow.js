function pacificAtlantic(heights) {
    if (heights.length === 0 || heights[0].length === 0) return [];

    const rows = heights.length;
    const cols = heights[0].length;
    const pacific = Array.from({ length: rows }, () => Array(cols).fill(false));
    const atlantic = Array.from({ length: rows }, () => Array(cols).fill(false));

    function dfs(r, c, visited) {
        visited[r][c] = true;
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc] && heights[nr][nc] >= heights[r][c]) {
                dfs(nr, nc, visited);
            }
        }
    }

    for (let r = 0; r < rows; r++) {
        dfs(r, 0, pacific);
        dfs(r, cols - 1, atlantic);
    }

    for (let c = 0; c < cols; c++) {
        dfs(0, c, pacific);
        dfs(rows - 1, c, atlantic);
    }

    const result = [];
    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (pacific[r][c] && atlantic[r][c]) {
                result.push([r, c]);
            }
        }
    }

    return result;
}