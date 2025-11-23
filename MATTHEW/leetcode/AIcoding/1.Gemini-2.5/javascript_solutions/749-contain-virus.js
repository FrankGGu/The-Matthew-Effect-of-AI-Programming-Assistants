var containVirus = function(grid) {
    const R = grid.length;
    const C = grid[0].length;
    const DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    let totalWalls = 0;

    while (true) {
        let regions = [];
        let visited = Array(R).fill(0).map(() => Array(C).fill(false));

        for (let r = 0; r < R; r++) {
            for (let c = 0; c < C; c++) {
                if (grid[r][c] === 1 && !visited[r][c]) {
                    let currentRegion = {
                        infectedCells: new Set(),
                        healthyCellsToInfect: new Set(),
                        wallsNeeded: 0
                    };
                    let queue = [[r, c]];
                    visited[r][c] = true;
                    currentRegion.infectedCells.add(`${r},${c}`);

                    let head = 0;
                    while (head < queue.length) {
                        let [cr, cc] = queue[head++];

                        for (let [dr, dc] of DIRS) {
                            let nr = cr + dr;
                            let nc = cc + dc;

                            if (nr >= 0 && nr < R && nc >= 0 && nc < C) {
                                if (grid[nr][nc] === 1 && !visited[nr][nc]) {
                                    visited[nr][nc] = true;
                                    currentRegion.infectedCells.add(`${nr},${nc}`);
                                    queue.push([nr, nc]);
                                } else if (grid[nr][nc] === 0) {
                                    if (!currentRegion.healthyCellsToInfect.has(`${nr},${nc}`)) {
                                        currentRegion.healthyCellsToInfect.add(`${nr},${nc}`);
                                        currentRegion.wallsNeeded++;
                                    }
                                }
                            }
                        }
                    }
                    if (currentRegion.healthyCellsToInfect.size > 0) {
                        regions.push(currentRegion);
                    }
                }
            }
        }

        if (regions.length === 0) {
            break;
        }

        regions.sort((a, b) => b.healthyCellsToInfect.size - a.healthyCellsToInfect.size);
        let regionToContain = regions[0];

        totalWalls += regionToContain.wallsNeeded;

        for (let cellStr of regionToContain.infectedCells) {
            let [r, c] = cellStr.split(',').map(Number);
            grid[r][c] = -1;
        }

        for (let i = 1; i < regions.length; i++) {
            let otherRegion = regions[i];
            for (let cellStr of otherRegion.healthyCellsToInfect) {
                let [r, c] = cellStr.split(',').map(Number);
                grid[r][c] = 1;
            }
        }
    }

    return totalWalls;
};