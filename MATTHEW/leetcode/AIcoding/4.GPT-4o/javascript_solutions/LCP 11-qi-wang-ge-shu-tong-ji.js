var getProbability = function(balls) {
    let totalBalls = balls.reduce((a, b) => a + b, 0);
    let totalWays = factorial(totalBalls);
    let colorWays = 1;

    for (let count of balls) {
        colorWays *= factorial(count);
    }

    return totalWays / colorWays;
};

var factorial = function(n) {
    if (n === 0) return 1;
    let result = 1;
    for (let i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
};