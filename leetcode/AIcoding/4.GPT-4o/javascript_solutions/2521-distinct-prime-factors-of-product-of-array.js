function distinctPrimeFactors(nums) {
    const primeFactors = new Set();

    function getPrimeFactors(n) {
        for (let i = 2; i * i <= n; i++) {
            while (n % i === 0) {
                primeFactors.add(i);
                n /= i;
            }
        }
        if (n > 1) primeFactors.add(n);
    }

    let product = 1;
    for (let num of nums) {
        product *= num;
    }

    getPrimeFactors(product);

    return primeFactors.size;
}