var containVirus = function(isInfected) {
    const m = isInfected.length;
    const n = isInfected[0].length;
    let walls = 0;

    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (true) {
        const regions = [];
        const infected = [];
        const frontiers = [];
        const perimeters = [];
        const visited = new Array(m).fill().map(() => new Array(n).fill(false));

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (isInfected[i][j] === 1 && !visited[i][j]) {
                    regions.push([]);
                    infected.push(new Set());
                    frontiers.push(new Set());
                    perimeters.push(0);
                    const index = regions.length - 1;
                    dfs(i, j, visited, regions[index], infected[index], frontiers[index], perimeters[index]);
                }
            }
        }

        if (regions.length === 0) break;

        let maxIndex = 0;
        for (let i = 0; i < frontiers.length; i++) {
            if (frontiers[i].size > frontiers[maxIndex].size) {
                maxIndex = i;
            }
        }

        walls += perimeters[maxIndex];

        for (let i = 0; i < regions.length; i++) {
            if (i === maxIndex) {
                for (const [x, y] of regions[i]) {
                    isInfected[x][y] = -1;
                }
            } else {
                for (const [x, y] of regions[i]) {
                    for (const [dx, dy] of dirs) {
                        const nx = x + dx;
                        const ny = y + dy;
                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && isInfected[nx][ny] === 0) {
                            isInfected[nx][ny] = 1;
                        }
                    }
                }
            }
        }
    }

    function dfs(x, y, visited, region, infected, frontier, perimeter) {
        if (visited[x][y]) return;
        visited[x][y] = true;
        region.push([x, y]);

        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                if (isInfected[nx][ny] === 1) {
                    dfs(nx, ny, visited, region, infected, frontier, perimeter);
                } else if (isInfected[nx][ny] === 0) {
                    frontier.add(`${nx},${ny}`);
                    perimeter++;
                }
            }
        }
    }

    return walls;
};