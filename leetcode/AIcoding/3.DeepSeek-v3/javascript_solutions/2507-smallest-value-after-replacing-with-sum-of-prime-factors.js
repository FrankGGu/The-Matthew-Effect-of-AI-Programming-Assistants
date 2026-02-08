var smallestValue = function(n) {
    const getPrimeFactors = (num) => {
        let sum = 0;
        for (let i = 2; i * i <= num; i++) {
            while (num % i === 0) {
                sum += i;
                num /= i;
            }
        }
        if (num > 1) {
            sum += num;
        }
        return sum;
    };

    let current = n;
    let prev = 0;
    while (current !== prev) {
        prev = current;
        current = getPrimeFactors(current);
    }
    return current;
};