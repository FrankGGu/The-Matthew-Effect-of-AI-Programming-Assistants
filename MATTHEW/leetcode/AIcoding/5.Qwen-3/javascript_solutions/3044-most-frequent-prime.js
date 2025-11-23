function mostFrequentPrime(matrix) {
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]];
    const primeCount = {};

    function isPrime(num) {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }

    function getPrimesFromDirection(row, col, dr, dc) {
        let current = 0;
        while (row >= 0 && row < matrix.length && col >= 0 && col < matrix[0].length) {
            current = current * 10 + matrix[row][col];
            if (isPrime(current)) {
                primeCount[current] = (primeCount[current] || 0) + 1;
            }
            row += dr;
            col += dc;
        }
    }

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[0].length; j++) {
            for (const [dr, dc] of directions) {
                getPrimesFromDirection(i, j, dr, dc);
            }
        }
    }

    let maxFreq = 0;
    let result = -1;

    for (const prime in primeCount) {
        const freq = primeCount[prime];
        if (freq > maxFreq || (freq === maxFreq && parseInt(prime) < result)) {
            maxFreq = freq;
            result = parseInt(prime);
        }
    }

    return result;
}