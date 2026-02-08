var pacificAtlantic = function(heights) {
    if (!heights || heights.length === 0 || heights[0].length === 0) {
        return [];
    }

    const rows = heights.length;
    const cols = heights[0].length;
    const pacific = Array(rows).fill(null).map(() => Array(cols).fill(false));
    const atlantic = Array(rows).fill(null).map(() => Array(cols).fill(false));

    const dfs = (r, c, visited) => {
        if (visited[r][c]) {
            return;
        }

        visited[r][c] = true;

        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newR = r + dr;
            const newC = c + dc;

            if (newR >= 0 && newR < rows && newC >= 0 && newC < cols && heights[newR][newC] >= heights[r][c]) {
                dfs(newR, newC, visited);
            }
        }
    };

    for (let c = 0; c < cols; c++) {
        dfs(0, c, pacific);
        dfs(rows - 1, c, atlantic);
    }

    for (let r = 0; r < rows; r++) {
        dfs(r, 0, pacific);
        dfs(r, cols - 1, atlantic);
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
};