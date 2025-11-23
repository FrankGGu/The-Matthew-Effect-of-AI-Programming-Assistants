var solveMaze = function(maze) {
    const n = maze.length;
    const m = maze[0].length;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    let queue = [];
    let startRow, startCol, endRow, endCol;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (maze[i][j] === 'S') {
                startRow = i;
                startCol = j;
            } else if (maze[i][j] === 'E') {
                endRow = i;
                endCol = j;
            }
        }
    }

    queue.push([startRow, startCol, 0]);
    maze[startRow][startCol] = '#';

    while (queue.length > 0) {
        const [row, col, steps] = queue.shift();

        if (row === endRow && col === endCol) {
            return steps;
        }

        for (const [dr, dc] of directions) {
            let newRow = row + dr;
            let newCol = col + dc;

            if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < m && maze[newRow][newCol] !== '#') {
                queue.push([newRow, newCol, steps + 1]);
                maze[newRow][newCol] = '#';
            }
        }
    }

    return -1;
};