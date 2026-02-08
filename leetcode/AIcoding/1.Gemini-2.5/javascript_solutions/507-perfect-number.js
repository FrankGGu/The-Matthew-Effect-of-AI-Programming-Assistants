var checkPerfectNumber = function(num) {
    if (num <= 1) {
        return false;
    }

    let sumOfDivisors = 1; // 1 is always a divisor

    for (let i = 2; i * i <= num; i++) {
        if (num % i === 0) {
            sumOfDivisors += i;
            if (i * i !== num) {
                sumOfDivisors += num / i;
            }
        }
    }

    return sumOfDivisors === num;
};