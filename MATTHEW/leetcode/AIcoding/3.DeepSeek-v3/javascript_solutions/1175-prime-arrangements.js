const numPrimeArrangements = function(n) {
    const MOD = 1e9 + 7;
    let count = countPrimes(n + 1);
    let res = 1;
    for (let i = 1; i <= count; i++) {
        res = (res * i) % MOD;
    }
    for (let i = 1; i <= n - count; i++) {
        res = (res * i) % MOD;
    }
    return res;
};

function countPrimes(n) {
    if (n <= 2) return 0;
    let count = 0;
    let isPrime = new Array(n).fill(true);
    isPrime[0] = false;
    isPrime[1] = false;
    for (let i = 2; i * i < n; i++) {
        if (isPrime[i]) {
            for (let j = i * i; j < n; j += i) {
                isPrime[j] = false;
            }
        }
    }
    for (let i = 2; i < n; i++) {
        if (isPrime[i]) count++;
    }
    return count;
}