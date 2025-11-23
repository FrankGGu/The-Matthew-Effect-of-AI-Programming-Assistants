function nthSuperUglyNumber(n, primes) {
    const ugly = new Array(n);
    ugly[0] = 1;
    const indices = new Array(primes.length).fill(0);
    const values = [...primes];

    for (let i = 1; i < n; i++) {
        const nextUgly = Math.min(...values);
        ugly[i] = nextUgly;

        for (let j = 0; j < values.length; j++) {
            if (values[j] === nextUgly) {
                indices[j]++;
                values[j] = ugly[indices[j]] * primes[j];
            }
        }
    }

    return ugly[n - 1];
}