var mostFrequentPrime = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],          [0, 1],
        [1, -1],  [1, 0], [1, 1]
    ];
    const primeCount = new Map();

    const isPrime = (num) => {
        if (num <= 1) return false;
        if (num === 2) return true;
        if (num % 2 === 0) return false;
        for (let i = 3; i <= Math.sqrt(num); i += 2) {
            if (num % i === 0) return false;
        }
        return true;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            for (const [dx, dy] of directions) {
                let x = i + dx;
                let y = j + dy;
                let num = mat[i][j];
                while (x >= 0 && x < m && y >= 0 && y < n) {
                    num = num * 10 + mat[x][y];
                    if (isPrime(num)) {
                        primeCount.set(num, (primeCount.get(num) || 0) + 1);
                    }
                    x += dx;
                    y += dy;
                }
            }
        }
    }

    if (primeCount.size === 0) return -1;

    let maxCount = -1;
    let result = -1;
    for (const [num, count] of primeCount) {
        if (count > maxCount || (count === maxCount && num > result)) {
            maxCount = count;
            result = num;
        }
    }
    return result;
};