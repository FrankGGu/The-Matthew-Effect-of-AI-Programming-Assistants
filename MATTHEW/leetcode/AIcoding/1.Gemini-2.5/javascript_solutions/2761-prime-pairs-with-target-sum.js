var findPrimePairs = function(n) {
    const isPrime = new Array(n + 1).fill(true);
    isPrime[0] = false;
    isPrime[1] = false;

    for (let p = 2; p * p <= n; p++) {
        if (isPrime[p]) {
            for (let i = p * p; i <= n; i += p) {
                isPrime[i] = false;
            }
        }
    }

    const result = [];
    for (let i = 2; i <= n / 2; i++) {
        if (isPrime[i] && isPrime[n - i]) {
            result.push([i, n - i]);
        }
    }

    return result;
};