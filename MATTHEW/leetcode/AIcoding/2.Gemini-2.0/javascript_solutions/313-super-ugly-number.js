var nthSuperUglyNumber = function(n, primes) {
    const ugly = new Array(n);
    ugly[0] = 1;
    const pointers = new Array(primes.length).fill(0);
    const values = new Array(primes.length).fill(1);

    for (let i = 1; i < n; i++) {
        let min = Infinity;
        for (let j = 0; j < primes.length; j++) {
            values[j] = primes[j] * ugly[pointers[j]];
            min = Math.min(min, values[j]);
        }

        ugly[i] = min;

        for (let j = 0; j < primes.length; j++) {
            if (values[j] === min) {
                pointers[j]++;
            }
        }
    }

    return ugly[n - 1];
};