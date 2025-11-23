function diagonalPrime(mat) {
    const n = mat.length;
    let maxPrime = 0;

    function isPrime(num) {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }

    for (let i = 0; i < n; i++) {
        if (isPrime(mat[i][i])) {
            maxPrime = Math.max(maxPrime, mat[i][i]);
        }
        if (isPrime(mat[i][n - 1 - i])) {
            maxPrime = Math.max(maxPrime, mat[i][n - 1 - i]);
        }
    }

    return maxPrime;
}