var countPrimeSetBits = function(left, right) {
    const isPrime = (num) => {
        if (num <= 1) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    let count = 0;
    for (let i = left; i <= right; i++) {
        const bits = i.toString(2).split('1').length - 1;
        if (isPrime(bits)) {
            count++;
        }
    }
    return count;
};