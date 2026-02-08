var sumFourDivisors = function(nums) {
    let sum = 0;
    for (let num of nums) {
        let divisors = [];
        for (let i = 1; i <= Math.sqrt(num); i++) {
            if (num % i === 0) {
                if (i * i === num) {
                    divisors.push(i);
                } else {
                    divisors.push(i);
                    divisors.push(num / i);
                }
            }
        }
        if (divisors.length === 4) {
            sum += divisors.reduce((a, b) => a + b, 0);
        }
    }
    return sum;
};