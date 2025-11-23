var hasPath = function(maze, start, destination) {
    const rows = maze.length;
    const cols = maze[0].length;

    const queue = [[start[0], start[1]]];
    const visited = new Array(rows).fill(0).map(() => new Array(cols).fill(false));
    visited[start[0]][start[1]] = true;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [r, c] = queue.shift();

        if (r === destination[0] && c === destination[1]) {
            return true;
        }

        for (const [dr, dc] of directions) {
            let newR = r;
            let newC = c;

            while (newR + dr >= 0 && newR + dr < rows && 
                   newC + dc >= 0 && newC + dc < cols && 
                   maze[newR + dr][newC + dc] === 0) {
                newR += dr;
                newC += dc;
            }

            if (!visited[newR][newC]) {
                visited[newR][newC] = true;
                queue.push([newR, newC]);
            }
        }
    }

    return false;
};