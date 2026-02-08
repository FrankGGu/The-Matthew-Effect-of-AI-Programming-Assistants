var smallestValue = function(n) {
    const primeFactorsSum = (num) => {
        let sum = 0;
        for (let i = 2; i <= Math.sqrt(num); i++) {
            while (num % i === 0) {
                sum += i;
                num /= i;
            }
        }
        if (num > 1) sum += num;
        return sum;
    };

    let current = n;
    let next = primeFactorsSum(current);
    while (next !== current) {
        current = next;
        next = primeFactorsSum(current);
    }
    return current;
};