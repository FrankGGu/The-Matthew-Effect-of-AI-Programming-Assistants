var canReach = function(maze, start, destination) {
    const rows = maze.length, cols = maze[0].length;
    const directions = [[1,0],[-1,0],[0,1],[0,-1]];
    const visited = new Set();
    const startKey = start[0] + ',' + start[1];
    visited.add(startKey);

    const dfs = (r, c) => {
        if (r === destination[0] && c === destination[1]) return true;
        for (const [dr, dc] of directions) {
            let nr = r, nc = c;
            while (nr + dr >= 0 && nr + dr < rows && nc + dc >= 0 && nc + dc < cols && maze[nr + dr][nc + dc] === 0) {
                nr += dr;
                nc += dc;
            }
            const nextKey = nr + ',' + nc;
            if (!visited.has(nextKey)) {
                visited.add(nextKey);
                if (dfs(nr, nc)) return true;
            }
        }
        return false;
    };

    return dfs(start[0], start[1]);
};