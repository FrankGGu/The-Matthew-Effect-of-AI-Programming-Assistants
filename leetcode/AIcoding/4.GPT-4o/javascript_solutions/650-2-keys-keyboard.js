var minSteps = function(n) {
    let steps = 0;
    for (let i = 2; i <= n; i++) {
        while (n % i === 0) {
            steps += i;
            n /= i;
        }
    }
    return steps;
};