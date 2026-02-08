var mostFrequentPrime = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const primeCounts = new Map();

    const dr = [-1, -1, -1, 0, 0, 1, 1, 1];
    const dc = [-1, 0, 1, -1, 1, -1, 0, 1];

    function isPrime(num) {
        if (num < 2) return false;
        if (num === 2) return true;
        if (num % 2 === 0) return false;
        for (let i = 3; i * i <= num; i += 2) {
            if (num % i === 0) return false;
        }
        return true;
    }

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            for (let k = 0; k < 8; k++) {
                let currNum = grid[r][c];
                let nr = r + dr[k];
                let nc = c + dc[k];

                while (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    currNum = currNum * 10 + grid[nr][nc];

                    if (isPrime(currNum)) {
                        primeCounts.set(currNum, (primeCounts.get(currNum) || 0) + 1);
                    }

                    nr += dr[k];
                    nc += dc[k];
                }
            }
        }
    }

    let maxFreq = 0;
    let result = -1;

    for (const [prime, freq] of primeCounts.entries()) {
        if (freq > maxFreq) {
            maxFreq = freq;
            result = prime;
        } else if (freq === maxFreq) {
            result = Math.max(result, prime);
        }
    }

    return result;
};