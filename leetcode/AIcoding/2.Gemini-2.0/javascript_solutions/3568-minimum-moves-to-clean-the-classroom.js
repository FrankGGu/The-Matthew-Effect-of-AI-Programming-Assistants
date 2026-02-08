var cleanClassroom = function(classroom) {
    const m = classroom.length;
    const n = classroom[0].length;
    let startRow = -1, startCol = -1;
    let dirty = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (classroom[i][j] === 'R') {
                startRow = i;
                startCol = j;
            } else if (classroom[i][j] === 'D') {
                dirty.push([i, j]);
            }
        }
    }

    const k = dirty.length;
    let dp = Array(1 << k).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << k); mask++) {
        if (dp[mask] === Infinity) continue;

        for (let i = 0; i < k; i++) {
            if ((mask & (1 << i)) === 0) {
                let cost = 0;
                if (mask === 0) {
                    cost = Math.abs(startRow - dirty[i][0]) + Math.abs(startCol - dirty[i][1]);
                } else {
                    let lastCleaned = -1;
                    for (let j = 0; j < k; j++) {
                        if ((mask & (1 << j)) !== 0) {
                            lastCleaned = j;
                            break;
                        }
                    }

                    let lastCleanedRow, lastCleanedCol;
                    if(lastCleaned != -1){
                        lastCleanedRow = dirty[lastCleaned][0];
                        lastCleanedCol = dirty[lastCleaned][1];
                    }else{
                        lastCleanedRow = startRow;
                        lastCleanedCol = startCol;
                    }

                    cost = Math.abs(lastCleanedRow - dirty[i][0]) + Math.abs(lastCleanedCol - dirty[i][1]);
                }

                dp[mask | (1 << i)] = Math.min(dp[mask | (1 << i)], dp[mask] + cost);
            }
        }
    }

    return dp[(1 << k) - 1];
};