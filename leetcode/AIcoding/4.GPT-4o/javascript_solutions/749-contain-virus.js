var containVirus = function(isInfected) {
    let totalWalls = 0;
    let totalInfected = 0;

    while (true) {
        const regions = [];
        const wallsNeeded = [];
        const infectedCount = [];
        const visited = Array.from({ length: isInfected.length }, () => Array(isInfected[0].length).fill(false));
        let foundRegion = false;

        for (let r = 0; r < isInfected.length; r++) {
            for (let c = 0; c < isInfected[0].length; c++) {
                if (isInfected[r][c] === 1 && !visited[r][c]) {
                    foundRegion = true;
                    const queue = [[r, c]];
                    visited[r][c] = true;
                    let walls = 0;
                    let count = 1;
                    const region = [];

                    while (queue.length > 0) {
                        const [x, y] = queue.shift();
                        region.push([x, y]);

                        for (const [dx, dy] of [[0, 1], [1, 0], [0, -1], [-1, 0]]) {
                            const nx = x + dx;
                            const ny = y + dy;

                            if (nx >= 0 && nx < isInfected.length && ny >= 0 && ny < isInfected[0].length) {
                                if (isInfected[nx][ny] === 1 && !visited[nx][ny]) {
                                    visited[nx][ny] = true;
                                    queue.push([nx, ny]);
                                    count++;
                                } else if (isInfected[nx][ny] === 0) {
                                    walls++;
                                }
                            }
                        }
                    }

                    regions.push(region);
                    wallsNeeded.push(walls);
                    infectedCount.push(count);
                }
            }
        }

        if (!foundRegion) break;

        const maxIndex = infectedCount.indexOf(Math.max(...infectedCount));
        totalWalls += wallsNeeded[maxIndex];

        for (let i = 0; i < regions.length; i++) {
            if (i === maxIndex) {
                for (const [x, y] of regions[i]) {
                    isInfected[x][y] = 1;
                }
            } else {
                for (const [x, y] of regions[i]) {
                    isInfected[x][y] = 2;
                }
            }
        }

        for (let r = 0; r < isInfected.length; r++) {
            for (let c = 0; c < isInfected[0].length; c++) {
                if (isInfected[r][c] === 1) {
                    for (const [dx, dy] of [[0, 1], [1, 0], [0, -1], [-1, 0]]) {
                        const nx = r + dx;
                        const ny = c + dy;

                        if (nx >= 0 && nx < isInfected.length && ny >= 0 && ny < isInfected[0].length) {
                            if (isInfected[nx][ny] === 0) {
                                isInfected[nx][ny] = 1;
                            }
                        }
                    }
                }
            }
        }

        for (let r = 0; r < isInfected.length; r++) {
            for (let c = 0; c < isInfected[0].length; c++) {
                if (isInfected[r][c] === 2) {
                    isInfected[r][c] = 0;
                }
            }
        }
    }

    return totalWalls;
};