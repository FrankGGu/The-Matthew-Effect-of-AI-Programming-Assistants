var pacificAtlantic = function(heights) {
    if (!heights || heights.length === 0 || heights[0].length === 0) return [];

    const rows = heights.length;
    const cols = heights[0].length;
    const pacific = new Array(rows).fill().map(() => new Array(cols).fill(false));
    const atlantic = new Array(rows).fill().map(() => new Array(cols).fill(false));
    const result = [];

    const dfs = (r, c, ocean) => {
        ocean[r][c] = true;
        const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !ocean[nr][nc] && heights[nr][nc] >= heights[r][c]) {
                dfs(nr, nc, ocean);
            }
        }
    };

    for (let r = 0; r < rows; r++) {
        dfs(r, 0, pacific);
        dfs(r, cols - 1, atlantic);
    }

    for (let c = 0; c < cols; c++) {
        dfs(0, c, pacific);
        dfs(rows - 1, c, atlantic);
    }

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (pacific[r][c] && atlantic[r][c]) {
                result.push([r, c]);
            }
        }
    }

    return result;
};