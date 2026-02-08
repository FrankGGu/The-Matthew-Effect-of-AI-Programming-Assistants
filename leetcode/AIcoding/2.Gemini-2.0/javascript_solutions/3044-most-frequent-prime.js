var mostFrequentPrime = function(mat) {
    const rows = mat.length;
    const cols = mat[0].length;
    const primes = new Set();

    function isPrime(n) {
        if (n <= 1) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    }

    function findPrimes(r, c, dr, dc) {
        let num = 0;
        while (r >= 0 && r < rows && c >= 0 && c < cols) {
            num = num * 10 + mat[r][c];
            if (num >= 10 && isPrime(num)) {
                primes.add(num);
            }
            r += dr;
            c += dc;
        }
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            findPrimes(i, j, 0, 1);
            findPrimes(i, j, 1, 0);
            findPrimes(i, j, 1, 1);
            findPrimes(i, j, 1, -1);
        }
    }

    const counts = new Map();
    for (const prime of primes) {
        counts.set(prime, (counts.get(prime) || 0) + 1);
    }

    let maxFreq = 0;
    let mostFrequent = -1;

    for (const [prime, count] of counts) {
        if (count > maxFreq) {
            maxFreq = count;
            mostFrequent = prime;
        } else if (count === maxFreq && prime > mostFrequent) {
            mostFrequent = prime;
        }
    }

    return mostFrequent;
};