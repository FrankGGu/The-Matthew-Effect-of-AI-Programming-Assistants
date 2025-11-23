function closestDivisors(num) {
    for (let i = Math.sqrt(num).toFixed(0); i >= 1; i--) {
        if (num % i === 0) {
            return [i, num / i];
        }
    }
    return [1, num];
}