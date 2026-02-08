var nthSuperUglyNumber = function(n, primes) {
    let ugly = [1];
    let pointers = new Array(primes.length).fill(0);

    while (ugly.length < n) {
        let next = Infinity;
        for (let i = 0; i < primes.length; i++) {
            next = Math.min(next, ugly[pointers[i]] * primes[i]);
        }
        for (let i = 0; i < primes.length; i++) {
            if (ugly[pointers[i]] * primes[i] === next) {
                pointers[i]++;
            }
        }
        ugly.push(next);
    }

    return ugly[n - 1];
};