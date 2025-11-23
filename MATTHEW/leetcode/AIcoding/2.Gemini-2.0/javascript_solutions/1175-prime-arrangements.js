var numPrimeArrangements = function(n) {
    let primeCount = 0;
    for (let i = 2; i <= n; i++) {
        let isPrime = true;
        for (let j = 2; j * j <= i; j++) {
            if (i % j === 0) {
                isPrime = false;
                break;
            }
        }
        if (isPrime) {
            primeCount++;
        }
    }

    let nonPrimeCount = n - primeCount;
    let primeArrangements = 1;
    for (let i = 1; i <= primeCount; i++) {
        primeArrangements = (primeArrangements * i) % 1000000007;
    }

    let nonPrimeArrangements = 1;
    for (let i = 1; i <= nonPrimeCount; i++) {
        nonPrimeArrangements = (nonPrimeArrangements * i) % 1000000007;
    }

    return (primeArrangements * nonPrimeArrangements) % 1000000007;
};