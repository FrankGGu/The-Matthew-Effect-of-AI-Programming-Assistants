var countPrimeSetBits = function(L, R) {
    let count = 0;
    const primes = new Set([2, 3, 5, 7, 11, 13, 17, 19]);

    for (let i = L; i <= R; i++) {
        let setBits = 0;
        let num = i;
        while (num > 0) {
            num &= (num - 1);
            setBits++;
        }

        if (primes.has(setBits)) {
            count++;
        }
    }

    return count;
};