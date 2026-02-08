var containVirus = function(isInfected) {
    let ans = 0;
    while (true) {
        let regions = [];
        let visited = new Set();
        let maxThreat = 0;
        let maxThreatIndex = -1;

        for (let i = 0; i < isInfected.length; i++) {
            for (let j = 0; j < isInfected[0].length; j++) {
                if (isInfected[i][j] === 1 && !visited.has(i * isInfected[0].length + j)) {
                    let region = [];
                    let threat = new Set();
                    let queue = [[i, j]];
                    visited.add(i * isInfected[0].length + j);
                    region.push([i, j]);

                    while (queue.length > 0) {
                        let [row, col] = queue.shift();
                        let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

                        for (let [dr, dc] of directions) {
                            let newRow = row + dr;
                            let newCol = col + dc;

                            if (newRow >= 0 && newRow < isInfected.length && newCol >= 0 && newCol < isInfected[0].length) {
                                if (isInfected[newRow][newCol] === 1 && !visited.has(newRow * isInfected[0].length + newCol)) {
                                    visited.add(newRow * isInfected[0].length + newCol);
                                    queue.push([newRow, newCol]);
                                    region.push([newRow, newCol]);
                                } else if (isInfected[newRow][newCol] === 0) {
                                    threat.add(newRow * isInfected[0].length + newCol);
                                }
                            }
                        }
                    }

                    regions.push({ region: region, threat: threat });

                    if (threat.size > maxThreat) {
                        maxThreat = threat.size;
                        maxThreatIndex = regions.length - 1;
                    }
                }
            }
        }

        if (regions.length === 0) break;

        if (maxThreatIndex === -1) break;

        ans += regions[maxThreatIndex].region.length * 4;

        for (let [row, col] of regions[maxThreatIndex].region) {
            isInfected[row][col] = -1;
        }

        for (let i = 0; i < regions.length; i++) {
            if (i !== maxThreatIndex) {
                for (let [row, col] of regions[i].region) {
                    let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

                    for (let [dr, dc] of directions) {
                        let newRow = row + dr;
                        let newCol = col + dc;

                        if (newRow >= 0 && newRow < isInfected.length && newCol >= 0 && newCol < isInfected[0].length && isInfected[newRow][newCol] === 0) {
                            isInfected[newRow][newCol] = 1;
                        }
                    }
                }
            }
        }

        let hasInfected = false;
        for(let i = 0; i < isInfected.length; i++) {
            for(let j = 0; j < isInfected[0].length; j++) {
                if(isInfected[i][j] === 1) {
                    hasInfected = true;
                    break;
                }
            }
            if(hasInfected) break;
        }

        if(!hasInfected) break;
    }

    return ans;
};