var countPrimes = function(n) {
    if (n <= 2) {
        return 0;
    }

    const isPrime = new Array(n).fill(true);
    isPrime[0] = false;
    isPrime[1] = false;

    for (let p = 2; p * p < n; p++) {
        if (isPrime[p]) {
            for (let multiple = p * p; multiple < n; multiple += p) {
                isPrime[multiple] = false;
            }
        }
    }

    let count = 0;
    for (let i = 2; i < n; i++) {
        if (isPrime[i]) {
            count++;
        }
    }

    return count;
};