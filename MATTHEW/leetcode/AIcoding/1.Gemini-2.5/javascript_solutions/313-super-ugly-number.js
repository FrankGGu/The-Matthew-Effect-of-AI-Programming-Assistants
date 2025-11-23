var nthSuperUglyNumber = function(n, primes) {
    if (n === 1) {
        return 1;
    }

    const ugly = new Array(n);
    ugly[0] = 1;

    const k = primes.length;
    const pointers = new Array(k).fill(0);

    for (let i = 1; i < n; i++) {
        let minVal = Infinity;
        for (let j = 0; j < k; j++) {
            minVal = Math.min(minVal, ugly[pointers[j]] * primes[j]);
        }
        ugly[i] = minVal;

        for (let j = 0; j < k; j++) {
            if (ugly[pointers[j]] * primes[j] === minVal) {
                pointers[j]++;
            }
        }
    }

    return ugly[n - 1];
};