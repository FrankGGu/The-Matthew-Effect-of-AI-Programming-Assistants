var closestDivisors = function(num) {
    const findDivisors = (n) => {
        for (let i = Math.floor(Math.sqrt(n)); i >= 1; i--) {
            if (n % i === 0) {
                return [i, n / i];
            }
        }
        return [1, n];
    };

    const [a1, b1] = findDivisors(num + 1);
    const [a2, b2] = findDivisors(num + 2);

    if (Math.abs(a1 - b1) < Math.abs(a2 - b2)) {
        return [a1, b1];
    } else {
        return [a2, b2];
    }
};