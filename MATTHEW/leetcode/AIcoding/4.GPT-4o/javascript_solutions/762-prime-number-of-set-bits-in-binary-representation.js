var isPrime = function(num) {
    if (num <= 1) return false;
    for (let i = 2; i * i <= num; i++) {
        if (num % i === 0) return false;
    }
    return true;
};

var countSetBits = function(n) {
    let count = 0;
    while (n > 0) {
        count += n & 1;
        n >>= 1;
    }
    return count;
};

var countPrimeSetBits = function(L, R) {
    let primeCount = 0;
    for (let i = L; i <= R; i++) {
        if (isPrime(countSetBits(i))) {
            primeCount++;
        }
    }
    return primeCount;
};