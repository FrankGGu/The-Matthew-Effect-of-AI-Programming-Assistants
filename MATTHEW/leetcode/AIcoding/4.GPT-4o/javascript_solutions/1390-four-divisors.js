var sumFourDivisors = function(nums) {
    let totalSum = 0;

    for (let num of nums) {
        let divisors = [];
        for (let i = 1; i * i <= num; i++) {
            if (num % i === 0) {
                divisors.push(i);
                if (i !== num / i) {
                    divisors.push(num / i);
                }
            }
            if (divisors.length > 4) break;
        }
        if (divisors.length === 4) {
            totalSum += divisors.reduce((a, b) => a + b, 0);
        }
    }

    return totalSum;
};